import os
import shutil
import subprocess
import tempfile
import tomllib
import unittest
from pathlib import Path


SOURCE = Path(__file__).resolve().parents[1]


class InstallTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name) / "playbook"
        self.home = Path(self.temp.name) / "home"
        self.home.mkdir()
        (self.home / ".codex").mkdir()
        shutil.copytree(SOURCE, self.root, ignore=shutil.ignore_patterns(".git", "__pycache__"))
        self.env = {**os.environ, "HOME": str(self.home)}

    def run_install(self, *args):
        return subprocess.run(
            [str(self.root / "scripts" / "install.sh"), *args],
            env=self.env,
            capture_output=True,
            text=True,
            check=True,
        )

    def test_dry_run_does_not_write(self):
        generated = self.root / "dist" / "AGENTS.md"
        before = generated.stat().st_mtime_ns
        result = self.run_install("codex")
        self.assertIn("dry-run", result.stdout)
        self.assertEqual(before, generated.stat().st_mtime_ns)
        self.assertFalse((self.home / ".agent-playbook").exists())
        self.assertFalse((self.home / ".codex" / "AGENTS.md").exists())

    def test_apply_links_generated_codex_artifacts(self):
        self.run_install("--apply", "codex")
        self.assertEqual((self.home / ".agent-playbook").resolve(), self.root)
        self.assertEqual((self.home / ".codex" / "AGENTS.md").resolve(), self.root / "dist" / "AGENTS.md")
        self.assertTrue((self.home / ".codex" / "rules" / "agent-playbook.rules").is_symlink())
        source_agents = sorted((self.root / "agents").glob("*.md"))
        installed_agents = sorted((self.home / ".codex" / "agents").glob("*.toml"))
        self.assertEqual(len(installed_agents), len(source_agents))
        for path in installed_agents:
            agent = tomllib.loads(path.read_text())
            self.assertEqual(agent["name"], path.stem)
            self.assertTrue(agent["developer_instructions"])
        self.assertTrue((self.home / ".agents" / "skills" / "engineering-workflow").is_symlink())


if __name__ == "__main__":
    unittest.main()
