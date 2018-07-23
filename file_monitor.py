#!/usr/bin/python
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

root_dir_path = '.'
monitored_file_name = ".mf"

filename = "kkk.txt"
monitored_files = []

def get_monitored_files():
    with open(monitored_file_name, 'r') as files:
        monitored_files = []
        for file in files:
            monitored_files.append(file)

class MyHandler(FileSystemEventHandler):
    def on_modified(self, event):
        print('event type: {}'.format(event.event_type))
        filename= event.src_path.split("{}/".format(root_dir_path))[1]

        if filename == ".mf":
            print ("Atualizando lista de arquivos")
            get_monitored_files()
        elif event.event_type == "modified" and filename in monitored_files:
            print ("path : {}".format(event.src_path))

if __name__ == "__main__":
    get_monitored_files()

    event_handler = MyHandler()
    observer = Observer()
    observer.schedule(event_handler, path=root_dir_path, recursive=False)
    observer.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()