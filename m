Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61741A707A
	for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179519; cv=none; b=kkOnfqXKaETh2FGj7dnryuCd+V6etEZtnGSegEB2gvkfryGwSVCRQ9Jrp/4ST77VJA2fByHaA6cHhgQSTn2uD17bafb+xgtlcA3bgOMZanYj51FQ7Enwdi0qLHo+eqLw4Xefa2BJOQo3nqA32jg4W9axfm4zY52+XDAvzBQjPJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179519; c=relaxed/simple;
	bh=WOPDNNUeD5sCrU2Gh20UEoMhHmD+a9gE6O2j8NUGbfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sbAZaawKP3JBRX1NzrAmMG6/LZqJN4pPTewlwXzrGJ1uapv025pChVGY7ZuUqSzuRUGBZXnvQsTG1BkwgiPVbnTVDXzYHg0qGXqt/So8EC1dE90oMXrm7/0jlmUZN2by35tILGP5iR32UGD32W/SUGXN/CeX5Wuq7DP0dk3knCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpNN3QAI; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpNN3QAI"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6c35357cdacso37030006d6.0
        for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 05:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727179516; x=1727784316; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gViNHPHf5IcyhfwjY8yBkY0iMYvg67DYXX0wC5m06Ko=;
        b=mpNN3QAIgKZdJn0v2+lLtJvCbXMwotTLgjzav117iL3FRCYcasmAmxjRSVrkJALg7u
         71Ca2ZVrH6cTRZUpSrr8YjjDpAukaOj+AqA4RWroRIDr0y+x2pLYkU+k18THUU48gq+G
         DH1QzSiwacN2JtKvhJ93UIUYf+9cFad6bBl0k++CbjE7A1CRRm6TOHccM6SN/sWXUAN1
         QW5NMbrG52VSnKDLpArMKzVDO0794df6Mxtn6WQLniQvhbkgo38Amx/Z4uL0/M6hCuWp
         ADN8jdGLFonX4/pKyn60pvcdWsRU5nlhJeofMHTbO/1adsVNvayoStekg6oxg6/E4XAL
         eQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179516; x=1727784316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gViNHPHf5IcyhfwjY8yBkY0iMYvg67DYXX0wC5m06Ko=;
        b=qEClHMJPHTH1FIOsnS71FNrDmmgw4TcGUGaIZY0L8KZ5P4Leg7P4/ajO5mLtptNy0+
         PtqqwSLDRD8RYXuFzL8fe0MOHLfgsZGgVN7Oe4ZiOGTCXCkI689CkSbVWXlpvpCVtjVg
         lwV+eBJ1wxH6X3FqqeANsLlExcj7bynCCV/iI2Y4h9TeuS7ry27ZU6tTPWg+5N7bOKhQ
         WpHAIa0KMLmjX/88YnghV4LlsocndXOK7L30frlnYtpPW/K+KRem9USCK7zWlsKPBffQ
         d7RA28qRXT5aPGSIwSzacOhNabZ4q5B06cs+MDrDGRg5WprVbfWIKPVFqJlfsixEBzLf
         htRg==
X-Gm-Message-State: AOJu0YxfHFOalTn3vVDleHnKrXd4iC56PLlm8WxkGvOvRxErfM8J4zD/
	Cpe1HTi3IPI9m7zcRtJpWLxdXT5utf9dz0y7uwOZX5bgB4RseLAYb7Awug==
X-Google-Smtp-Source: AGHT+IH27xoawgey6waMsCDnvvypGttcgauiBZP5/S/4/klEB7wPl4V0MoG3cjxYSNY0kb6l3ZWb7w==
X-Received: by 2002:a05:6214:3990:b0:6c3:5dcf:bf5a with SMTP id 6a1803df08f44-6c7bd5e2475mr234001206d6.37.1727179516294;
        Tue, 24 Sep 2024 05:05:16 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4a6178sm5948056d6.7.2024.09.24.05.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:05:15 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 16/16] doc: Document new DeviceProvisioningAgent
Date: Tue, 24 Sep 2024 05:04:47 -0700
Message-Id: <20240924120447.251761-16-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924120447.251761-1-prestwoj@gmail.com>
References: <20240924120447.251761-1-prestwoj@gmail.com>
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
index e9bb95ca..1cc7eafe 100644
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
+		void CancelSharedCode(string reason) [noreply]
+
+			This method gets called to indicate that the agent
+			request for a shared code failed before a reply was
+			returned. The argument will indicate why the request is
+			being cancelled and may be "user-canceled", "timed-out"
+			or "shutdown".
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

