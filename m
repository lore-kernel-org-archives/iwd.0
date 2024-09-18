Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7391ACE0F
	for <iwd@lists.linux.dev>; Wed, 18 Sep 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726681213; cv=none; b=D+5muzlZ70A5abx0Vq1HxoDuZ9ioXR+LzEXOjd7L5jq9vhACdXyLdpAHPLqQXFLybLVjrLnNw4KzfK5VIYU960ZzfZHErBfVI8qsXek5vOdW1gvZXqg4hWIiuJPfu1+5qaGkMEya3o+o8Y3ISVXgfB23A6OReVjM+YDK5s3Rc1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726681213; c=relaxed/simple;
	bh=i7w0B/6WnO6X2xLc0h0/5DoKSNyV+y8CAbvck+W1YSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zmp/1K5KWhStZbQrU249Z5Gbhcos5Ph7giKbAMCEr3Vk4zslrVKnqdXkFLxzCdFRD64/6979KNxf+OpyvDdxbd19h2tFbDnOLa+QrvdCZKGXwg8qZSukRGyJ6uB9qUvMD58rflFWDsv+STWfGQ5tWbfVZpAPTRkHg6fKAN0F/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7NdvjU7; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7NdvjU7"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-710e01dd554so3559530a34.3
        for <iwd@lists.linux.dev>; Wed, 18 Sep 2024 10:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726681210; x=1727286010; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0J8P4RgxRYZ7Mlr0x+7QWQwV65rxUCRHTrbwWT65h20=;
        b=g7NdvjU73BnVlEI0NGf0jrj8l7AfuTyVITm+sHT9E01TUWOvEDp34M/DODAa9ByVmn
         IUwjmL6i2wqOIgxO841BzY8QrqCcl17u3JKea2WkeitDyD7nPS+1nR8nhYCNJ+KXfxaS
         yfraP+vs0YkojdZyWrBnU1ZPGEqrV5upr7a0XB4UOiganIuVhJQiLLHqlHxM2XUIeGS+
         wJJu9JMBIZ/wEYDPYT970yAxl3iNoDBfHg8wnUAZFaaaD3AOJ1kq2e1iZjeKjPGEU9/j
         SlInaIE7/5fxozqgLtl0VRfNMEkUubt5FTj/dpG12hkmjC5McAXzwDAwohyYws2VdQzW
         kmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726681210; x=1727286010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0J8P4RgxRYZ7Mlr0x+7QWQwV65rxUCRHTrbwWT65h20=;
        b=njiwXzmE/b7N3fne91b2paCtdAQx5rFsHp9v2YW0pypjURWCincmGeEbwKCWVboYQX
         85NLCgGgBGjQMizddCyv5EvY76hFxGkW2EHEbIXphmU8ieNwPunNxi8TcISZD0UdV8/o
         UWDKt/FoL82FS5At9a17U0KlWsMvLSTVYwlERFEW047ftf1laMq9Tu45ryMeHH2sTKrM
         9VYw7t0Jn49B3Q4Y4OmDdadQPp462bAl5i/mRssQ+nAhRpcpSbF47ndnuZTZJestL6AX
         /ShPggOZ1FT2/CU8Vb8Tib3lb2BOfeMVYnaanUmt4CuJxxzTDFJ5bN/WgMXw9L6yUlD7
         szMA==
X-Gm-Message-State: AOJu0YzUs3zHUmFLZaP+RjhElafngFjjuWNmn98PBfgs+bULBN4KjMca
	vCILt0Q3QG2Uc68IVyYvayj+q0exMSxk4NamDhpv7QUkP+1Xmfr5sAQ0tQ==
X-Google-Smtp-Source: AGHT+IEM3gAVvPig4AFs5J3hB3xxix0IAab2Zr/qLKJ5GfO1GlAhgJeAkNv+phMii14VHrJDclAvOg==
X-Received: by 2002:a05:6358:7e54:b0:1b5:ecc9:1e48 with SMTP id e5c5f4694b2df-1bb23e0410fmr637344955d.25.1726681210046;
        Wed, 18 Sep 2024 10:40:10 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3e95bbc6sm477375185a.7.2024.09.18.10.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 10:40:09 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 1/2] doc: Document new DeviceProvisioningAgent
Date: Wed, 18 Sep 2024 10:40:01 -0700
Message-Id: <20240918174002.68663-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This moves the SharedCodeAgent docs into the AgentManager interface
and renames it to DeviceProvisioningAgent. The agent path parameter
was also removed from the StartConfigurator() method.
---
 doc/agent-api.txt               | 56 +++++++++++++++++++++++++++++++++
 doc/device-provisioning-api.txt | 48 ++++------------------------
 2 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index e9bb95ca..dc5529f3 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -67,6 +67,31 @@ Methods		void RegisterAgent(object path)
 					 [service].NotFound
 					 [service].NotAvailable
 
+		void RegisterDeviceProvisioningAgent(object path)
+
+			Register an agent for handling Device Provisioning (DPP)
+			specific requests.
+
+			This includes:
+			 - Requests for shared codes when using shared code
+			   device provisioning.
+			 - Requests for certificate signing requests
+			 - Requests to send a certificate signing request
+
+			The details of these are explained in the DBus method
+			docs below for the
+			net.connman.iwd.DeviceProvisioningAgent interface.
+
+
+			Possible Errors: [service].InvalidArguments
+					 [service].AlreadyExists
+
+		void UnregisterDeviceProvisioningAgent(object path)
+
+			Unregisters an existing Device Provisioning agent
+
+			Possible Errors: [service].InvalidArguments
+					 [service].NotFound
 
 Agent hierarchy
 ===============
@@ -263,3 +288,34 @@ Methods		void Release() [noreply]
 		void CancelIPv6(object device, string reason) [noreply]
 
 			Same as CancelIPv4 above but for IPv6.
+
+DeviceProvisioningAgent hierarchy
+=================================
+
+Service		unique name
+Interface	net.connman.iwd.DeviceProvisioningAgent [Experimental]
+Object path	freely definable
+
+Methods		void Release() [noreply]
+
+			This method gets called when the service daemon
+			unregisteres the agent
+
+		void Cancel(string reason) [noreply]
+
+			This method gets called to indicate that the agent
+			request failed before a reply was returned. The
+			argument will indicate why the request is being
+			cancelled and may be "user-canceled", "timed-out" or
+			"shutdown".
+
+		string RequestSharedCode(string identifier)
+
+			This method gets called when a shared code is requested
+			for a particular enrollee, distingushed by the
+			identifier. The shared code agent should lookup the
+			identifier and return the shared code, or return an
+			error if not found.
+
+			Possible Errors:	[service].Error.Canceled
+						[service].Error.NotFound
diff --git a/doc/device-provisioning-api.txt b/doc/device-provisioning-api.txt
index 6cf16fb8..37d8f67e 100644
--- a/doc/device-provisioning-api.txt
+++ b/doc/device-provisioning-api.txt
@@ -132,14 +132,13 @@ Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
 			Possible errors:	net.connman.iwd.Busy
 						net.connman.iwd.InvalidArguments
 
-		void StartConfigurator(object agent_path)
+		void StartConfigurator(void)
 
-			Start a shared code configurator using an agent
-			(distingushed by 'agent_path') to obtain the shared
-			code. This method is meant for an automated use case
-			where a configurator is capable of configuring multiple
-			enrollees, and distinguishing between them by their
-			identifier.
+			Start a shared code configurator which depends on an
+			agent (registered via AgentManager). This method is
+			meant for an automated use case where a configurator is
+			capable of configuring multiple enrollees, and
+			distinguishing between them by their identifier.
 
 			If the agent service disappears during the shared code
 			exchange it will be stopped, and the protocol will fail.
@@ -180,38 +179,3 @@ Properties	boolean Started [readonly]
 			Indicates the DPP role. Possible values are "enrollee"
 			or "configurator". This property is only available when
 			Started is true.
-
-SharedCodeAgent hierarchy
-=========================
-
-Service		unique name
-Interface	net.connman.iwd.SharedCodeAgent [Experimental]
-Object path	freely definable
-
-Methods		void Release() [noreply]
-
-			This method gets called when the service daemon
-			unregisters the agent.
-
-		string RequestSharedCode(string identifier)
-
-			This method gets called when a shared code is requested
-			for a particular enrollee, distingushed by the
-			identifier. The shared code agent should lookup the
-			identifier and return the shared code, or return an
-			error if not found.
-
-			Possible Errors:	[service].Error.Canceled
-						[service].Error.NotFound
-
-		void Cancel(string reason) [noreply]
-
-			This method gets called to indicate that the agent
-			request failed before a reply was returned. The
-			argument will indicate why the request is being
-			cancelled and may be "user-canceled", "timed-out" or
-			"shutdown".
-
-Examples	Requesting a shared code for an enrollee identified by "foo"
-
-			RequestSharedCode("foo") ==> "super_secret_code"
-- 
2.34.1

