Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF5530DD1F
	for <iwd@lists.linux.dev>; Fri, 24 Apr 2026 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019540; cv=none; b=vB+6J7d4Ou4TtEfw6rKBV9pMIRoEzjjdA9Myvbv4JqRzxshIiZFLnuZMCCaG+4+hxG9uAhcJ9qLov4sgyFHtzGK+bS0iRK5AypzuaiAweOqUg0jExDqug6O+MRznvanPvnzwaXiiTSiDPBhCFya8SjOuezTf0qEVkokc6Q0u+iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019540; c=relaxed/simple;
	bh=r3VAzywNLU5lrhnbb6zJa0Kd88xlQ/qwAFpcbUMc6/4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5HiylMa4RZjgetT14kjOIF73i9WAbwPk/cBwj3AjJ5o06CCmuNJ6lXIsIp5LuPSG1+eOz41DeDcxvBB5Ank/L0Ptc7HGTn5MxVAJ8KpVh3uwYuzB2+f1KCXtRrb8+CYnGOjMGY73dPJicKKCl9voP5/8+chzttKObimAAKHbJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=iOItgBRF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="iOItgBRF"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so69681975e9.0
        for <iwd@lists.linux.dev>; Fri, 24 Apr 2026 01:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1777019535; x=1777624335; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hztyXuxqUVCHLtDLQTv1VQuIvgNSVbUxK7z5bwfA0aE=;
        b=iOItgBRFoF/bgEGcz0UGrRYdbOxbYRF7G3/xQVR28iBBIdHpbePvlhkHOSjIpR/Dti
         ch7Xar0SfRgXR5VcOyT8QW+PF3zeeRTyBtt3opz1n9F1ZQ8/8eqYrW3wH2h6rGuFntBt
         ABLmAo2uQ5Z4w/DGNOZW6EGoMZs5S2mTZ+8Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777019535; x=1777624335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hztyXuxqUVCHLtDLQTv1VQuIvgNSVbUxK7z5bwfA0aE=;
        b=f1gXiTqgNcWClcONKLnDZlhlxLFIC+3F0zeEbAwDkdXUoKFLAwrsJo9LN57ivdTeo/
         mannZ0L6hOWl+MXlDQpIC+uw3z0r4gtB7bA9kvYnwVOzNUt2+bLvr36DA/wtP0Q6E9lZ
         ZfkZbR+Th6IGNWemtLLmsZeHTL8S/OJVuBw1PReTvRI6ES8DeAB9qPs56PZaxviiNMva
         o543coLwnHcXCnbbUdrfiYcr0Hnnxa8zO4ssvdy6QyxkI1AjGyUF/xKz08KmX3hlssRd
         X2Y0yDaLkLwGxxaDn2/ZI7ywTe9dXe9Xe2jQoIpsqRtlELZCbNxYhjrv6cHUAxZQ8gDe
         xLUA==
X-Gm-Message-State: AOJu0YwcZiB0hRFgXz3fqkqQrwP3JmSD0bj8sS5Q0LBlW0m83+Qorlfl
	tSE8MKw9ZckZCiVCbO1Z1ASeJK9VQyymTo9cts9mqjk30RifRrv42LFb2BqzGqNwx2HCn7UYh8f
	eOBzP
X-Gm-Gg: AeBDieuRVrfAv71VTolRq4AEHSdZq82/jxJDlRBV8CFHukh+aF7lxKPlNRYNDdcamym
	Ws16KpqeSObmfnlojI6R0ExjQTeKjjD3V2FxPMyjy5+UDh4MlQCOABCoFqsVDH6EH+F4mjGb661
	yTnCFScIV6k3eGD8oeTZdFtiPGTFhquv8Xl2YFhcUz1yZkq+LHQtEwEChSGefphWQUPpiE6Fs8D
	Be6hAOIFCb8JMXgj8XqKOftLLZfzk4OZRrcqlEvat1Gx+83c6+pZ5b63gPrMfpNr9K6No44CSDT
	RVE6I/qWfXREUXSEQtIPLUGEITsw5RgQ+i87Sjj2h93xTodvyuS0ao3qvknf5Euk66pDDU5KBfs
	TD/KT9mLUKxKz+ILMkKXSOzoXhdVwh22nSa8eGP3gOEjFPgTz7sOQSUB4XL6PRysE4mQdASffU6
	LysMlXVYJfAYD52Rt96yPunR4DcY/CGs+M5oAhtvRfuierz+bgeFO46AO5bTfSGF4OYS9ciE8/e
	c1wT+8oh0k6rjwCH4sOxE0oQ2CE16bj2RRbRunFtswMsb68GMaL73xTTIsdHvwhZaz4+7Cf4GQc
	rrmj5F4pQ2Khj0gcBvrom0KLQepPZG9IviuJp+MrzndEESzWggqETO7GoBYoyu75M1gy1JFniGS
	Ig1CTbSyaChFEg8lIgEh3
X-Received: by 2002:a05:600c:4fc6:b0:48a:53ea:1408 with SMTP id 5b1f17b1804b1-48a53ea15a4mr230601105e9.8.1777019535096;
        Fri, 24 Apr 2026 01:32:15 -0700 (PDT)
Received: from mkurz-macbook-pro.fritz.box (2a02-8388-82c0-2a80-8de6-cca3-34a7-690d.cable.dynamic.v6.surfer.at. [2a02:8388:82c0:2a80:8de6:cca3:34a7:690d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c01cfsm601386945e9.10.2026.04.24.01.32.14
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 01:32:14 -0700 (PDT)
From: Matthias Kurz <m.kurz@irregular.at>
To: iwd@lists.linux.dev
Subject: [PATCH 2/3] doc: Document passphrase storage options
Date: Fri, 24 Apr 2026 10:31:58 +0200
Message-ID: <20260424083209.383093-3-m.kurz@irregular.at>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260424083209.383093-1-m.kurz@irregular.at>
References: <20260424083209.383093-1-m.kurz@irregular.at>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document RequestPassphraseWithOptions and the Store option for agents
that want to control whether a PSK passphrase is saved in the network
profile.
---
 doc/agent-api.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index e9bb95ca..77e9bc6d 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -90,6 +90,18 @@ Methods		void Release() [noreply]
 
 			Possible Errors: net.connman.iwd.Agent.Error.Canceled
 
+		(string, dict) RequestPassphraseWithOptions(object network)
+
+			This method gets called when trying to connect to
+			a network and passphrase is required.  Agents
+			implementing this method can return options for the
+			passphrase.  If the Store boolean option is present
+			and false, IWD will use the passphrase for this
+			connection attempt but will not save it to the
+			network profile.
+
+			Possible Errors: net.connman.iwd.Agent.Error.Canceled
+
 		string RequestPrivateKeyPassphrase(object network)
 
 			This method gets called when connecting to
-- 
2.54.0

