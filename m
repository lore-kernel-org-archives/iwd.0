Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F183928F2
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 20:03:39 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id 19so2716651ljz.4
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 13:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sgqdLoKDFr2r3SPkGfcyn+WSZlcMfAj5g7Sl8oYeC5E=;
        b=LBDTsEyAf0c/uA3gfWsUjdR0eKgc737UY01cF/9E8Jukv4hXmja7W0JeeUQKW0Hsl+
         3sOTIoJc+3amDm9+SEzgeI/ZvSPVxlqXx8fiX9zvcRi7uVwhFi2wrDsrZvOYea0GSe5N
         OWuddw0/iNQe6oqygavRN3XY8hgb2n8UpwuKqkdCu2k54Wd8XvqrdkgSlpjAjxO92kdy
         +u+5U02aqnsih/AXWgcgE5nzibWHApF/eHnV6GvzxZIwMEYFWlBIOGqwCzy9UKG/nrYm
         F15DkE0fE4Y628s8YrhOM63uHizFC2o1CBj93XThXQYTFnhaLq1fbb2lIMADVZRc/DsN
         2wyQ==
X-Gm-Message-State: AJIora+QPldgGGhX8GbaA98EIMIrv6qdqeLCvl9KFaqIjVkBDx3kZJQa
	hF3dEZnTetQUnrYq3NU9SXXQ4nSerQKMExjk
X-Google-Smtp-Source: AGRyM1v+TK0ztqNZ0ooJdbE1SXiRlDi1V5dpgQHWIBs98OlOfoDObl7sf8hIbHfH4F5QciIIAExgEg==
X-Received: by 2002:a2e:9dcb:0:b0:25d:16eb:2671 with SMTP id x11-20020a2e9dcb000000b0025d16eb2671mr17392567ljj.46.1657224217488;
        Thu, 07 Jul 2022 13:03:37 -0700 (PDT)
Received: from localhost.localdomain (public-gprs650242.centertel.pl. [5.184.83.67])
        by smtp.gmail.com with ESMTPSA id 9-20020ac25f09000000b004791e47c5b8sm6525269lfq.175.2022.07.07.13.03.36
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 13:03:36 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH v2 1/4] test-runner: Support running hostapd in namespaces
Date: Thu,  7 Jul 2022 22:03:06 +0200
Message-Id: <20220707200309.3276163-1-andrew.zaborowski@intel.com>
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

 tools/run-tests | 82 ++++++++++++++++++++++++++++++++-----------------
 tools/utils.py  |  2 +-
 2 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/tools/run-tests b/tools/run-tests
index 565847df..c0f230cb 100755
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
 
@@ -397,32 +407,44 @@ class TestContext(Namespace):
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
@@ -543,11 +565,13 @@ class TestContext(Namespace):
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

