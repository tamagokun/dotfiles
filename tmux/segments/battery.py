import os
import sys
import subprocess;

def run_cmd(cmd):
	from subprocess import Popen, PIPE
	try:
		p = Popen(cmd, stdout=PIPE)
		stdout, err = p.communicate()
	except OSError as e:
		sys.stderr.write('Could not execute command ({0}): {1}\n'.format(e, cmd))
		return None
	return stdout.strip()

print run_cmd(['/Users/mkruk/dotfiles/tmux/segments/battery.sh',''])
