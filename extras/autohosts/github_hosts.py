import requests

hosts_url = "https://gitee.com/xueweihan/codes/6g793pm2k1hacwfbyesl464/raw?blob_name=GitHub520.yml"
start_flag = "# GitHub520 Host Start"
end_flag = "# GitHub520 Host End"


def set_hosts():
    hosts = []
    start_index = -1
    end_index = -1
    with open("/etc/hosts", 'r+') as f:
        lines = f.readlines()
        for i in range(len(lines)):
            hosts.append(lines[i])
            if lines[i].startswith(start_flag):
                start_index = i
            if lines[i].startswith(end_flag):
                end_index = i

        del hosts[start_index:end_index + 1]
        available_hosts = requests.get(hosts_url).text.splitlines()
        final_hosts = "".join(hosts) + "\n".join(available_hosts)
        f.seek(0)
        f.truncate()
        f.write(final_hosts)
    f.close()
    print("SUCCESS! /etc/hosts has been changed, visit https://github.com")


if __name__ == '__main__':
    set_hosts()
