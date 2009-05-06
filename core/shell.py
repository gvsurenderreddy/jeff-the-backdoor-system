
import os
import re
import subprocess
import sys


def handle_command (parts) :
	if len (parts) == 0 :
		crash ('zero command parts')
	jbs_exec = os.getenv ('JBS_EXEC', None)
	if jbs_exec is None :
		crash ('undefined JBS_EXEC')
	try :
		process = subprocess.Popen ([jbs_exec] + parts)
		outcome = process.wait ()
	except Exception, error :
		crash ('subprocess raised exception')
	if outcome != 0 :
		crash ('command failed')
	return None


command_pattern = r'^[ \t]*(?:(?:[^ \t]+)[ \t]*)+[ \t]*$'
command_part_pattern = r'[^ \t]+'
command_re = re.compile (command_pattern)
command_part_re = re.compile (command_part_pattern)

def interpret_command (line) :
	matched = command_re.match (line)
	if matched is None :
		crash ('unmatched command line')
	parts = command_part_re.findall (line)
	if len (parts) == 0 :
		crash ('empty command line')
	return handle_command (parts)


def interpret_stream (stream) :
	while True :
		line = stream.readline ()
		if line == '' :
			break
		line = line.strip ('\n\r')
		if line == '' :
			continue
		error = interpret_command (line)
		if error is not None :
			crash ('interpret_command failed')
	return None


def crash (message) :
	printf_error ('crashing: %s!', message)
	sys.exit (1)
	while True :
		pass


def printf_information (format, * parts) :
	return printf_ ('[ii]', format, parts)

def printf_warning (format, * parts) :
	return printf_ ('[ww]', format, parts)

def printf_error (format, * parts) :
	return printf_ ('[ee]', format, parts)

def printf_ (prefix, format, parts) :
	return print_ (prefix, format % parts)

def print_ (prefix, message) :
	sys.stderr.write (prefix + ' ' + message + '\n')
	sys.stderr.flush ()
	return None


def main (arguments) :
	if len (arguments) == 0 :
		error = interpret_stream (sys.stdin)
		if error is not None :
			crash ('interpret_stream failed')
	elif len (arguments) == 1 :
		error = interpret_command (arguments[0])
		if error is not None :
			crash ('interpret_command failed')
	sys.exit (0)

if __name__ == '__main__' :
	main (sys.argv[1:])
else :
	crash ('shell.py not loaded as __main__')

sys.exit (1)
