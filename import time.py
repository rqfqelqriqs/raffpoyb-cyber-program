import time
import os

def welcome_stream():
    print("Welcome to Raffpoyb_Cyber_Program!")
    print("/$$$$$$$   /$$$$$$  /$$$$$$$$ /$$$$$$$$ /$$$$$$$   /$$$$$$  /$$     /$$ /$$$$$$$         /$$$$$$  /$$     /$$ /$$$$$$$  /$$$$$$$$ /$$$$$$$        /$$$$$$$  /$$$$$$$   /$$$$$$   /$$$$$$   /$$$$$$  /$$$$$$$   /$$$$$$  /$$      /$$")
    print("| $$__  $$ /$$__  $$| $$_____/| $$_____/| $$__  $$ /$$__  $$|  $$   /$$/| $$__  $$       /$$__  $$|  $$   /$$/| $$__  $$| $$_____/| $$__  $$      | $$__  $$| $$__  $$ /$$__  $$ /$$__  $$ /$$__  $$| $$__  $$ /$$__  $$| $$$    /$$$")
    print("| $$  \ $$| $$  \ $$| $$      | $$      | $$  \ $$| $$  \ $$ \  $$ /$$/ | $$  \ $$      | $$  \__/ \  $$ /$$/ | $$  \ $$| $$      | $$  \ $$      | $$  \ $$| $$  \ $$| $$  \ $$| $$  \ $$| $$  \__/| $$  \ $$| $$  \ $$| $$$$  /$$$$")
    print("| $$$$$$$/| $$$$$$$$| $$$$$   | $$$$$   | $$$$$$$/| $$  | $$  \  $$$$/  | $$$$$$$       | $$        \  $$$$/  | $$$$$$$ | $$$$$   | $$$$$$$/      | $$$$$$$/| $$$$$$$/| $$  | $$| $$  | $$| $$ /$$$$| $$$$$$$/| $$$$$$$$| $$ $$/$$ $$")
    print("| $$__  $$| $$__  $$| $$__/   | $$__/   | $$____/ | $$  | $$   \  $$/   | $$__  $$      | $$         \  $$/   | $$__  $$| $$__/   | $$__  $$      | $$____/ | $$__  $$| $$  | $$| $$  | $$| $$|_  $$| $$__  $$| $$__  $$| $$  $$$| $$")
    print("| $$  \ $$| $$  | $$| $$      | $$      | $$      | $$  | $$    | $$    | $$  \ $$      | $$    $$    | $$    | $$  \ $$| $$      | $$  \ $$      | $$      | $$  \ $$| $$  | $$| $$  | $$| $$  \ $$| $$  \ $$| $$  | $$| $$\  $ | $$")
    print("| $$  | $$| $$  | $$| $$      | $$      | $$      |  $$$$$$/    | $$    | $$$$$$$/      |  $$$$$$/    | $$    | $$$$$$$/| $$$$$$$$| $$  | $$      | $$      | $$  | $$|  $$$$$$/|  $$$$$$/|  $$$$$$/| $$  | $$| $$  | $$| $$ \/  | $$")
    print("|__/  |__/|__/  |__/|__/      |__/      |__/       \______/     |__/    |_______/        \______/     |__/    |_______/ |________/|__/  |__/      |__/      |__/  |__/ \______/  \______/  \______/ |__/  |__/|__/  |__/|__/     |__/")
    current_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
    print(f"Current time: {current_time}")

if __name__ == "__main__":
    welcome_stream()
    def create_and_list_directory():
        directory_name = "Phone # Tracking"
        if not os.path.exists(directory_name):
            os.makedirs(directory_name)
        print(f"Contents of the '{directory_name}' directory:")
        print(os.listdir(directory_name))

    if __name__ == "__main__":
        welcome_stream()
        create_and_list_directory()
        def run_hydra():
            command = "hydra -l username -P password_list.txt ssh://target-ip"
            os.system(command)

        def create_password_hacking_directory():
            directory_name = "Password Hacking"
            if not os.path.exists(directory_name):
                os.makedirs(directory_name)
            print(f"Contents of the '{directory_name}' directory:")
            print(os.listdir(directory_name))

        create_password_hacking_directory()
    
    
