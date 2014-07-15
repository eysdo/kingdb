CC=g++
CFLAGS=-O3 -g -Wall -std=c++11 -stdlib=libc++ -Wc++11-extensions -Wl,-no-as-needed -c
INCLUDES=-I/opt/local/include/
LDFLAGS=-g -lprofiler
LDFLAGS_CLIENT=-g -L/opt/local/lib/ -lmemcached -lprofiler -fPIC 
SOURCES=kingdb.cc logger.cc status.cc server.cc buffer_manager.cc event_manager.cc murmurhash3.cc
SOURCES_MAIN=main.cc
SOURCES_CLIENT=client.cc
SOURCES_CLIENT_EMB=client_embedded.cc
OBJECTS=$(SOURCES:.cc=.o)
OBJECTS_MAIN=$(SOURCES_MAIN:.cc=.o)
OBJECTS_CLIENT=$(SOURCES_CLIENT:.cc=.o)
OBJECTS_CLIENT_EMB=$(SOURCES_CLIENT_EMB:.cc=.o)
EXECUTABLE=server
CLIENT=client
CLIENT_EMB=client_emb
LIBRARY=kingdb.a

all: $(SOURCES) $(LIBRARY) $(EXECUTABLE) $(CLIENT) $(CLIENT_EMB)

$(EXECUTABLE): $(OBJECTS) $(OBJECTS_MAIN)
	$(CC) $(LDFLAGS) $(OBJECTS) $(OBJECTS_MAIN) -o $@

$(CLIENT): $(OBJECTS) $(OBJECTS_CLIENT)
	$(CC) $(LDFLAGS_CLIENT) $(OBJECTS) $(OBJECTS_CLIENT) -o $@

$(CLIENT_EMB): $(OBJECTS) $(OBJECTS_CLIENT_EMB)
	$(CC) $(LDFLAGS_CLIENT) $(OBJECTS) $(OBJECTS_CLIENT_EMB) -o $@
#	$(CC) $(LDFLAGS_CLIENT) $(OBJECTS_CLIENT_EMB) $(LIBRARY) -o $@

$(LIBRARY): $(OBJECTS)
	rm -f $@
	ar -rs $@ $(OBJECTS)

.cc.o:
	$(CC) $(CFLAGS) $(INCLUDES) $< -o $@

clean:
	rm -f *~ .*~ *.o $(EXECUTABLE) $(CLIENT) $(CLIENT_EMB) $(LIBRARY)
