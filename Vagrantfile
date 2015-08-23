Vagrant.configure("2") do |config|
  config.vm.define "trusty" do |app|
    app.vm.box = "phusion/ubuntu-14.04-amd64"

    if Dir.glob("#{File.dirname(__FILE__)}/.vagrant/machines/default/*/id").empty?
      pkg_cmd = "export DEBIAN_FRONTEND=noninteractive;"
      # Install Docker and stuff
      pkg_cmd << "wget -q -O - https://get.docker.io/gpg | apt-key add -;" \
        "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list;" \
        "echo deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main  > /etc/apt/sources.list.d/ansible.list;" \
        "apt-get update -qq; apt-get dist-upgrade -y --force-yes; apt-get install -q -y --force-yes lxc-docker atop htop traceroute software-properties-common ansible; "
      # Add vagrant user to the docker group
      pkg_cmd << "usermod -a -G docker vagrant; "
      # clean up for smaller image
      pkg_cmd << "apt-get clean;rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;dd if=/dev/zero of=/EMPTY bs=1M;sudo rm -f /EMPTY;cat /dev/null > ~/.bash_history && history -c;"
      app.vm.provision :shell, :inline => pkg_cmd
    end

    app.vm.provider "virtualbox" do |v|
      v.memory  = 1536
      v.cpus = 2
    end

    app.nfs.functional = false
  end
end
