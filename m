Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A236C149
	for <iwd@lists.linux.dev>; Thu,  4 May 2023 21:52:54 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-74e07c2ee30so51140585a.1
        for <iwd@lists.linux.dev>; Thu, 04 May 2023 14:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683237173; x=1685829173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQuDwq4QcohWCNMiI2T2pNurGlqXf1VPAOlysnx3BpA=;
        b=S2FxDCxR/PJJcakKFzou1cZ4K2PAu0GZUWUO3o77W5gWwMKh5YQ0gNtuYBMf7abIDc
         wh+gIRW69BAF0offLymkmY4zaOog/zvFx8rqy7IaMdgkgVL5oS9sZgHS3Q4nBwHuLmSK
         qPL2oFy9Nl4gO3qlI6t5vbE/BMy2qpjDNIxH3cuVDIP1akk1T/EP6+9Uie+tH1o3QSNA
         8WYENPMMhQgpxIWBCwy4dbR/ijqovE/tm/cHCGv1Lzois6mTfyj29bXyj0GAsQe92H4l
         XaU9YmBGjpnGW23T4iuNsO0wkJnSMVDJUuRrbgY+JhbS2rzNrHvnqo1G4/p8ltkFPLrq
         2Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683237173; x=1685829173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQuDwq4QcohWCNMiI2T2pNurGlqXf1VPAOlysnx3BpA=;
        b=UXuwNQfxbALnttiLvwdqnWPOOyPb7P5IyFUSdZJOnhrOdXiBOFgBltbuP04sl7YBR9
         eDvxIVEZ5g5J0KYl09erqJzkykELiMbRo7aAQVNEM2nNFUqsHR2qOVGIZwIrwBOD+n7n
         kAN5oUjdYt8o8vW+pSKeEfpcNmlAmKcB5i6G/OXI1nM/zxZlxRkwg2BYuh4/ZOapCLDS
         TLbMiyKWcspbjUyELJyLh55O5qOOgl0uA0jkF0lawj1n60BSPddIjGvV39mdyzj4b5k/
         WbNP85hGDwutQJo6htrVbdk0junVDfFvK61sbH43XJlEoFYluvQmzJ71mjLMxBI/LGvy
         ZJ4Q==
X-Gm-Message-State: AC+VfDwQyUhKZnU3xQjxrzLUNYLa8dS5Px2jFqQPMnAkuvi6vbOlM8F5
	7fNvE4gXgV3sEPRTBRxzemi4RdJWPJg=
X-Google-Smtp-Source: ACHHUZ4BF8SPR8O5Q1iyfni3apQwE7ssQ9ov6MUhsklTqX6w/18mJCa9rE6fux6GGGfUUjK+Z1VlZA==
X-Received: by 2002:ad4:5fca:0:b0:5ef:5138:1e5d with SMTP id jq10-20020ad45fca000000b005ef51381e5dmr18637014qvb.49.1683237173036;
        Thu, 04 May 2023 14:52:53 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id v9-20020a0cdd89000000b0061b5b399d1csm52262qvk.104.2023.05.04.14.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 14:52:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] test-runner: allow hwsim in namespaces
Date: Thu,  4 May 2023 14:52:46 -0700
Message-Id: <20230504215247.581443-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504215247.581443-1-prestwoj@gmail.com>
References: <20230504215247.581443-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starts the hwsim daemon per-namespace rather than only in the
root namespace.
---
 tools/run-tests | 16 ++++++++--------
 tools/utils.py  | 13 ++++++++++++-
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/tools/run-tests b/tools/run-tests
index 32c09723..ef316666 100755
--- a/tools/run-tests
+++ b/tools/run-tests
@@ -319,6 +319,7 @@ class TestContext(Namespace):
 		self.namespaces = []
 		self._last_mem_available = 0
 		self._mem_chart = BarChart()
+		self.register_hwsim = False;
 
 	def start_dbus_monitor(self):
 		if not Process.is_verbose('dbus-monitor'):
@@ -329,18 +330,16 @@ class TestContext(Namespace):
 	def start_haveged(self):
 		self.start_process(['haveged', '-F'])
 
+	def start_hwsim(self):
+		self.register_hwsim = self.hw_config['SETUP'].get('hwsim_medium', 'no') in ['no', '0', 'false']
+
+		super().start_hwsim(self.register_hwsim)
+
 	def create_radios(self):
 		setup = self.hw_config['SETUP']
 		nradios = int(setup['num_radios'])
 		args = ['hwsim']
 
-		if self.hw_config['SETUP'].get('hwsim_medium', 'no') in ['no', '0', 'false']:
-			# register hwsim as medium
-			args.extend(['--no-register'])
-
-		proc = self.start_process(args)
-		proc.wait_for_service(self, 'net.connman.hwsim', 20)
-
 		for i in range(nradios):
 			name = 'rad%u' % i
 
@@ -524,7 +523,7 @@ class TestContext(Namespace):
 			# Remove radios from 'root' namespace
 			self.radios = list(set(self.radios) - set(radios))
 
-			self.namespaces.append(Namespace(self.args, key, radios))
+			self.namespaces.append(Namespace(self.args, key, radios, self.register_hwsim))
 
 	def get_namespace(self, ns):
 		for n in self.namespaces:
@@ -865,6 +864,7 @@ def pre_test(ctx, test, copied):
 	ctx.start_dbus()
 	ctx.start_haveged()
 	ctx.start_dbus_monitor()
+	ctx.start_hwsim()
 	ctx.start_radios()
 	ctx.create_namespaces()
 	ctx.start_hostapd()
diff --git a/tools/utils.py b/tools/utils.py
index a07c3183..d2e1c33b 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -320,7 +320,7 @@ busconfig.dtd\">
 '''
 
 class Namespace:
-	def __init__(self, args, name, radios):
+	def __init__(self, args, name, radios, hwsim_register=False):
 		self.dbus_address = None
 		self.name = name
 		self.radios = radios
@@ -331,6 +331,7 @@ class Namespace:
 			r.set_namespace(self)
 
 		self.start_dbus()
+		self.start_hwsim(register=hwsim_register)
 
 	def reset(self):
 		self._bus = None
@@ -458,6 +459,16 @@ class Namespace:
 
 		return proc
 
+	def start_hwsim(self, register=False):
+		args = ['hwsim']
+
+		if register:
+			# register hwsim as medium
+			args.extend(['--no-register'])
+
+		proc = self.start_process(args)
+		proc.wait_for_service(self, 'net.connman.hwsim', 20)
+
 	@staticmethod
 	def non_block_wait(func, timeout, *args, exception=True):
 		'''
-- 
2.25.1

