ERLC=/usr/local/bin/erlc
RM=rm -v -f

all: clean compile

compile:
	$(ERLC) -o ebin +debug_info src/*.erl

clean:
	$(RM) ebin/*.beam
