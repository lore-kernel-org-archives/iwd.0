Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB72258B
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 16:57:16 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id d16so16594750wrv.10
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 09:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gGI1wCmQvj/N+jA37xl5HKk6D75ZqD07F9XxN2vOrLY=;
        b=lHjWF3tdAop2/i47b/E+76N8/W50p3MDK7g76umU4G6bJa1y+o4YTQXcrz+wHYgEg7
         sbqzmtVALmdA0/OzyfUqMUpRUocwUFGe1dSbtGNQVjXEnrFrF61g/+kZgG7ahiO4I3KL
         NoRl480LSnjDCSmY3VdRp6hou5vvxzpJTVRjbxy7JiznnFspx13Eut//Y5Avb8V5P6Ue
         G75semyWxA7JzQ0MmnY4zThdSy6UHxVKMXnqSH64t8nOWMszkGoZ4gA2w5RoFbKds5jf
         0apnroHtIgC8YdZucNrg8Q3+VOFpNLO6w46Poa5nl1iLrFJAdUElVVi8D7/Focja5reT
         znuQ==
X-Gm-Message-State: AJIora8zbtdn2rJIxSoyt4WZq9JVyWeE+YsGPuoek4L1450z5cq+Ba0+
	1hjd8+lRiyxsCZVzUfIov8uo3A2wR9zUvznj
X-Google-Smtp-Source: AGRyM1uYR/3WId05o/IvBIPRx6J8RfpCf/fXyld/uDa7ulbUZvQtXr5sri5F4QLUOfudb2hUs6bhuQ==
X-Received: by 2002:a5d:47a5:0:b0:21d:19b8:f8fe with SMTP id 5-20020a5d47a5000000b0021d19b8f8femr38115777wrb.23.1657126634636;
        Wed, 06 Jul 2022 09:57:14 -0700 (PDT)
Received: from localhost.localdomain ([46.222.51.165])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b0039c5642e430sm29147856wmq.20.2022.07.06.09.57.12
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:57:14 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 1/5] test-runner: Support running hostapd in namespaces
Date: Wed,  6 Jul 2022 18:56:58 +0200
Message-Id: <20220706165702.3241756-1-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel will not let us test some scenarios of communication between
two hwsim radios (e.g. STA and AP) if they're in the same net namespace.
For example, when connected, you can't add normal IPv4 subnet routes for
the same subnet on two different interfaces in one namespace (you'd
either get an EEXIST or you'd replace the other route), you can set
different metrics on the routes but that won't fix IP routing.  For
testNetconfig the result is that communication works for DHCP before we
get the inital lease but renewals won't work because they're unicast.
Allow hostapd to run on a radio that has been moved to a different
namespace in hw.conf so we don't have to work around these issues.
---
 tools/run-tests | 80 +++++++++++++++++++++++++++++++------------------
 tools/utils.py  |  2 +-
 2 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/tools/run-tests b/tools/run-tests
index 565847df..f916fba6 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -58,16 +58,19 @@ def exit_vm():
 	runner.stop()
 
 class Interface:
-	def __init__(self, name, config):
+	def __init__(self, name, config, ns=None):
 		self.name = name
 		self.ctrl_interface = '/var/run/hostapd/' + name
 		self.config = config
+		self.ns = ns
 
 	def __del__(self):
-		Process(['iw', 'dev', self.name, 'del']).wait()
+		Process(['iw', 'dev', self.name, 'del'],
+				namespace=self.ns.name if self.ns else None).wait()
 
 	def set_interface_state(self, state):
-		Process(['ip', 'link', 'set', self.name, state]).wait()
+		Process(['ip', 'link', 'set', self.name, state],
+				namespace=self.ns.name if self.ns else None).wait()
 
 class Radio:
 	def __init__(self, name):
@@ -75,11 +78,16 @@ class Radio:
 		# hostapd will reset this if this radio is used by it
 		self.use = 'iwd'
 		self.interface = None
+		self.ns = None
 
 	def __del__(self):
 		print("Removing radio %s" % self.name)
 		self.interface = None
 
+	def set_namespace(self, ns):
+		self.ns = ns
+		Process(['iw', 'phy', self.name, 'set', 'netns', 'name', ns.name]).wait()
+
 	def create_interface(self, config, use):
 		global intf_id
 
@@ -87,19 +95,21 @@ class Radio:
 
 		intf_id += 1
 
-		self.interface = Interface(ifname, config)
+		self.interface = Interface(ifname, config, ns=self.ns)
 		self.use = use
 
 		Process(['iw', 'phy', self.name, 'interface', 'add', ifname,
-				'type', 'managed']).wait()
+				'type', 'managed'], namespace=self.ns.name if self.ns else None).wait()
 
 		return self.interface
 
 	def __str__(self):
 		ret = self.name + ':\n'
-		ret += '\tUsed By: %s ' % self.use
+		ret += '\tUsed By: %s' % self.use
 		if self.interface:
-			ret += '(%s)' % self.interface.name
+			ret += ' (%s)' % self.interface.name
+		if self.ns is not None:
+			ret += ' (ns=%s)' % self.ns.name
 
 		ret += '\n'
 
@@ -188,7 +198,7 @@ class Hostapd:
 		A set of running hostapd instances. This is really just a single
 		process since hostapd can be started with multiple config files.
 	'''
-	def __init__(self, radios, configs, radius):
+	def __init__(self, ns, radios, configs, radius):
 		if len(configs) != len(radios):
 			raise Exception("Config (%d) and radio (%d) list length not equal" % \
 						(len(configs), len(radios)))
@@ -198,8 +208,8 @@ class Hostapd:
 		Process(['ip', 'link', 'set', 'eth0', 'up']).wait()
 		Process(['ip', 'link', 'set', 'eth1', 'up']).wait()
 
-		self.global_ctrl_iface = '/var/run/hostapd/ctrl'
-
+		self.ns = ns
+		self.global_ctrl_iface = '/var/run/hostapd/ctrl' + (str(ns.name) if ns.name else 'main')
 		self.instances = [HostapdInstance(c, r) for c, r in zip(configs, radios)]
 
 		ifaces = [rad.interface.name for rad in radios]
@@ -227,7 +237,7 @@ class Hostapd:
 		if Process.is_verbose('hostapd'):
 			args.append('-d')
 
-		self.process = Process(args)
+		self.process = Process(args, namespace=ns.name)
 
 		self.process.wait_for_socket(self.global_ctrl_iface, 30)
 
@@ -397,32 +407,42 @@ class TestContext(Namespace):
 			#          tests. In this case you would not care what
 			#          was using each radio, just that there was
 			#          enough to run all tests.
-			nradios = 0
-			for k, _ in settings.items():
-				if k == 'radius_server':
-					continue
-				nradios += 1
-
-			hapd_radios = self.radios[:nradios]
-
+			hapd_configs = [conf for rad, conf in settings.items() if rad != 'radius_server']
+			hapd_processes = [(self, self.radios[:len(hapd_configs)], hapd_configs)]
 		else:
-			hapd_radios = [rad for rad in self.radios if rad.name in settings]
-
-		hapd_configs = [conf for rad, conf in settings.items() if rad != 'radius_server']
+			hapd_processes = []
+			for ns in [self] + self.namespaces:
+				ns_radios = [rad for rad in ns.radios if rad.name in settings]
+				if len(ns_radios):
+					ns_configs = [settings[rad.name] for rad in ns_radios]
+					hapd_processes.append((ns, ns_radios, ns_configs))
 
 		radius_config = settings.get('radius_server', None)
 
-		self.hostapd = Hostapd(hapd_radios, hapd_configs, radius_config)
-		self.hostapd.attach_cli()
+		self.hostapd = [Hostapd(ns, radios, configs, radius_config)
+				for ns, radios, configs in hapd_processes]
+
+		for hapd in self.hostapd:
+			hapd.attach_cli()
 
 	def get_frequencies(self):
 		frequencies = []
 
-		for hapd in self.hostapd.instances:
-			frequencies.append(hapd.cli.frequency)
+		for hapd in self.hostapd:
+			frequencies += [instance.cli.frequency for instance in hapd.instances]
 
 		return frequencies
 
+	def get_hapd_instance(self, config=None):
+		instances = [i for hapd in self.hostapd for i in hapd.instances]
+
+		if config is None:
+			return instances[0]
+
+		for hapd in instances:
+			if hapd.config == config:
+				return hapd
+
 	def start_wpas_interfaces(self):
 		if 'WPA_SUPPLICANT' not in self.hw_config:
 			return
@@ -543,11 +563,13 @@ class TestContext(Namespace):
 		for arg in vars(self.args):
 			ret += '\t --%s %s\n' % (arg, str(getattr(self.args, arg)))
 
-		ret += 'Hostapd:\n'
 		if self.hostapd:
-			for h in self.hostapd.instances:
-				ret += '\t%s\n' % str(h)
+			for hapd in self.hostapd:
+				ret += 'Hostapd (ns=%s):\n' % (hapd.ns.name,)
+				for h in hapd.instances:
+					ret += '\t%s\n' % (str(h),)
 		else:
+			ret += 'Hostapd:\n'
 			ret += '\tNo Hostapd instances\n'
 
 		info = self.meminfo_to_dict()
diff --git a/tools/utils.py b/tools/utils.py
index f3e12a85..bc030230 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -324,7 +324,7 @@ class Namespace:
 
 		Process(['ip', 'netns', 'add', name]).wait()
 		for r in radios:
-			Process(['iw', 'phy', r.name, 'set', 'netns', 'name', name]).wait()
+			r.set_namespace(self)
 
 		self.start_dbus()
 
-- 
2.34.1

