Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC11B7B
	for <iwd@lists.linux.dev>; Sat,  9 Jul 2022 00:23:47 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id m18so233963lfg.10
        for <iwd@lists.linux.dev>; Fri, 08 Jul 2022 17:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oMRtQtgUz2EtBbp03irnzLKde5/LAmHU5gXcX1O9N9E=;
        b=mvFM9DHCEMWrczEKkMPcyvF3A5iI62NaBQ+fXjpsoKYkvIta6YqcKOCHLNQtnvZFW9
         pcEranluLWAdscoubNdrBp/cLbAmWQjvasR/D0kqbRjvO0UR6mrO3hEZeOcAA+vHFdn5
         NK5tiMamqoqEAu/5LFbwkxrIgzQNDGCDyMPvXTss8yOysc3VTDCgeeHvGUVh0pySo7Yc
         O2sHfc0l03HVlTsI86X0CX4DAkoalTxx/8eVvglc80H64sypbU4Mx6rW3Cg7KOhE7uJV
         acIwlN5PlVqgCUq+J8+cfEaH0z9ibfqzy2wgO9B1+5jWtDSfmcsqqNWPWY8OL4BubUzs
         EImQ==
X-Gm-Message-State: AJIora/e1kYBhBmME6H+XYZHkWWLlLnBolKPPAKh+nFLLpNKwC5ZerCE
	BwDu2DbV4Cljhur5O5eCoULNvbFCu9Xn2NvF
X-Google-Smtp-Source: AGRyM1uE3cGKPyWJeMKNvdDKed15Hnd4kljLt0A6XCrNfjAdVzp0qqIoLClfBxO3g36te/+Wmy+3bQ==
X-Received: by 2002:a05:6512:31d0:b0:47f:9f1e:f08b with SMTP id j16-20020a05651231d000b0047f9f1ef08bmr3830044lfe.250.1657326225553;
        Fri, 08 Jul 2022 17:23:45 -0700 (PDT)
Received: from localhost.localdomain (public-gprs650242.centertel.pl. [5.184.83.67])
        by smtp.gmail.com with ESMTPSA id f19-20020ac25333000000b00478fe690207sm75603lfh.286.2022.07.08.17.23.44
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 17:23:44 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH v3 1/4] test-runner: Support running hostapd in namespaces
Date: Sat,  9 Jul 2022 02:23:31 +0200
Message-Id: <20220709002334.3329502-1-andrew.zaborowski@intel.com>
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
changes in v2:
 - ensure at least one hostapd session starts if the [HOSTAPD] section
   is present to mimic original behaviour and fix testEAD
v3:
 - make sure Radio.ns and Interface.ns are always valid (equal ctx
   instead of None) to simplify Process(namespace=self.ns) calls

 tools/run-tests | 90 ++++++++++++++++++++++++++++++-------------------
 tools/utils.py  |  2 +-
 2 files changed, 57 insertions(+), 35 deletions(-)

diff --git a/tools/run-tests b/tools/run-tests
index 565847df..76784aa3 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -58,28 +58,34 @@ def exit_vm():
 	runner.stop()
 
 class Interface:
-	def __init__(self, name, config):
+	def __init__(self, name, config, ns):
 		self.name = name
 		self.ctrl_interface = '/var/run/hostapd/' + name
 		self.config = config
+		self.ns = ns
 
 	def __del__(self):
-		Process(['iw', 'dev', self.name, 'del']).wait()
+		Process(['iw', 'dev', self.name, 'del'], namespace=self.ns.name).wait()
 
 	def set_interface_state(self, state):
-		Process(['ip', 'link', 'set', self.name, state]).wait()
+		Process(['ip', 'link', 'set', self.name, state], namespace=self.ns.name).wait()
 
 class Radio:
-	def __init__(self, name):
+	def __init__(self, name, default_ns):
 		self.name = name
 		# hostapd will reset this if this radio is used by it
 		self.use = 'iwd'
 		self.interface = None
+		self.ns = default_ns
 
 	def __del__(self):
 		print("Removing radio %s" % self.name)
 		self.interface = None
 
+	def set_namespace(self, ns):
+		self.ns = ns
+		Process(['iw', 'phy', self.name, 'set', 'netns', 'name', ns.name]).wait()
+
 	def create_interface(self, config, use):
 		global intf_id
 
@@ -87,19 +93,21 @@ class Radio:
 
 		intf_id += 1
 
-		self.interface = Interface(ifname, config)
+		self.interface = Interface(ifname, config, self.ns)
 		self.use = use
 
 		Process(['iw', 'phy', self.name, 'interface', 'add', ifname,
-				'type', 'managed']).wait()
+				'type', 'managed'], namespace=self.ns.name).wait()
 
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
 
@@ -113,7 +121,7 @@ class VirtualRadio(Radio):
 		than the command line.
 	'''
 
-	def __init__(self, name, cfg=None):
+	def __init__(self, name, default_ns, cfg=None):
 		global config
 
 		self.disable_cipher = None
@@ -129,7 +137,7 @@ class VirtualRadio(Radio):
 					iftype_disable=self.disable_iftype,
 					cipher_disable=self.disable_cipher)
 
-		super().__init__(self._radio.name)
+		super().__init__(self._radio.name, default_ns)
 
 	def __del__(self):
 		super().__del__()
@@ -188,7 +196,7 @@ class Hostapd:
 		A set of running hostapd instances. This is really just a single
 		process since hostapd can be started with multiple config files.
 	'''
-	def __init__(self, radios, configs, radius):
+	def __init__(self, ns, radios, configs, radius):
 		if len(configs) != len(radios):
 			raise Exception("Config (%d) and radio (%d) list length not equal" % \
 						(len(configs), len(radios)))
@@ -198,8 +206,8 @@ class Hostapd:
 		Process(['ip', 'link', 'set', 'eth0', 'up']).wait()
 		Process(['ip', 'link', 'set', 'eth1', 'up']).wait()
 
-		self.global_ctrl_iface = '/var/run/hostapd/ctrl'
-
+		self.ns = ns
+		self.global_ctrl_iface = '/var/run/hostapd/ctrl' + (str(ns.name) if ns.name else 'main')
 		self.instances = [HostapdInstance(c, r) for c, r in zip(configs, radios)]
 
 		ifaces = [rad.interface.name for rad in radios]
@@ -227,7 +235,7 @@ class Hostapd:
 		if Process.is_verbose('hostapd'):
 			args.append('-d')
 
-		self.process = Process(args)
+		self.process = Process(args, namespace=ns.name)
 
 		self.process.wait_for_socket(self.global_ctrl_iface, 30)
 
@@ -340,7 +348,7 @@ class TestContext(Namespace):
 			if self.hw_config.has_section(name):
 				rad_config = self.hw_config[name]
 
-			self.radios.append(VirtualRadio(name, rad_config))
+			self.radios.append(VirtualRadio(name, self, rad_config))
 
 	def discover_radios(self):
 		import pyroute2
@@ -362,7 +370,7 @@ class TestContext(Namespace):
 					break
 
 		print('Discovered radios: %s' % str(phys))
-		self.radios = [Radio(name) for name in phys]
+		self.radios = [Radio(name, self) for name in phys]
 
 	def start_radios(self):
 		reg_domain = self.hw_config['SETUP'].get('reg_domain', None)
@@ -397,32 +405,44 @@ class TestContext(Namespace):
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
+			if not hapd_processes:
+				hapd_processes.append((self, [], []))
 
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

