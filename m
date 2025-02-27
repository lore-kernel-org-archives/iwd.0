Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B8B271277
	for <iwd@lists.linux.dev>; Thu, 27 Feb 2025 21:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692565; cv=none; b=iLcG5YfLyvbvq3OvZnsn0Yny/uJ6OhTB9A84r4GbtAGhvC46V8wQ63fnb5x1C/PsVfNPE8/Gvs73xEZUbYQ5uWn91aIF4GZlDKVlWlGPj7OOI3Gltv10JBlCTjGOoVX5dTc664Civntq4FUMn1wKI/IH+GsC45PS/shvrIA4SHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692565; c=relaxed/simple;
	bh=ylujLenRApEOaFIXRUXeMSG2du9Zbi+t4pX5mvNLa0Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=V9ef6CovkswFs4/pPooX9qy9pn9NKfFh4oiwIqL2UiR9eOLZsvi6pCGaI9QuyGxr/VFjAqZo0g9/ZD33q8l42TIbV049AHCXJiLhJ+wSAPJTzz/U7Mdz0BWYis506vsbgXHSvuQ2Pwi223Y2RYqkfVyDORTxYSsAjVIh3KZ0s3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6f6c90b51c3so13662237b3.2
        for <iwd@lists.linux.dev>; Thu, 27 Feb 2025 13:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740692561; x=1741297361;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kVDaCN1H9wvSFos9mbaT9Ni3ECPs4UX7U7bMAmvGjpw=;
        b=r+tQd4Eo20FMQ2R8f2tFqY/9TUivY2u726PUY4yRdv6xFYBmWW8ReB9VBEIYtEFRH+
         QG0zvYm4G77TIJgAwLx7s1UlDlQvWAvf8/nGV7T/xZPcyPux4OQGaK94I5iJoG/ZlRiz
         9dNoepWmmcUqydM0hzkmrtPw05DfKQAMgBFaz9CsTSrOrJapo1cADEllmke6KqEQ12KG
         fBE68ixGXhKst1A8Zea5gVnBZuMGQm8J51LdM3Sg7mq31HUTD1gimzviqESPohwZUyIs
         BXd2dZCWnYGu+R+vED8ieb6V3iSa6MeK5805i61j7b7eJR+SeXQTXJT3XLdaBJehgVVc
         VYvw==
X-Gm-Message-State: AOJu0Ywk+hZYWteoJn/JsGm+IpMvCyMtCT75u0FGUyqrM96pSlcVOkkG
	68efQvs4BzKlLHcnQMyjocMoap+ifbgE66WHSRMsgSvkZ+39SaMq5fcySw==
X-Gm-Gg: ASbGnctdmKKsOCePUqp4qaodZwq6kRNnMAx06lF+Lx7GGdoLnWD3VPh0snVApxVNAjI
	JoRrtnf5OOCzq5HPrmYx8a5RmqNWQ/EpEqDHutsT7kO3j94nnHNRmmMlMCAu0E34Nanr/nj1WOP
	/rtdkxBC61CdomEPFCcpGGqlL9oFoGm38XojVaJ0Mh6uTio7QCXXK2N5oE+GOjjS6gsqvPlSHlb
	gb39PBjlnjPzSNpbCXBmOLxiaGxMspfgztraKDI89lOhvhltYzQcOpZ6heGzZ5eKWINmKL1YgUL
	IhpgmJcv3y3nnuQ5dGksKQ8jqnwqcngbpkg1HlDTpZ2lulJUJyou7B4NCWSFFp/WC8Metg==
X-Google-Smtp-Source: AGHT+IEax3pWv7J8sT4RCs5PVj4SpRiJ/iWlUyUslnRFn27ljI2sbpMqaBR9OZJJpyS2z24GIFch7g==
X-Received: by 2002:a05:690c:4c04:b0:6fb:b907:d94b with SMTP id 00721157ae682-6fd4a08f53fmr16019137b3.17.1740692560877;
        Thu, 27 Feb 2025 13:42:40 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3ca100b3sm4616387b3.13.2025.02.27.13.42.40
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 13:42:40 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e545c1e8a15so1792411276.1
        for <iwd@lists.linux.dev>; Thu, 27 Feb 2025 13:42:40 -0800 (PST)
X-Received: by 2002:a05:6902:1502:b0:e58:14b:6f99 with SMTP id
 3f1490d57ef6-e60b2e91b51mr1031350276.1.1740692560094; Thu, 27 Feb 2025
 13:42:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Thu, 27 Feb 2025 14:42:29 -0700
X-Gmail-Original-Message-ID: <CADXxVS+UQfrbWFfsDnW1QvkpvmEnkxMdv+OPBy=XpPXEFdcU8Q@mail.gmail.com>
X-Gm-Features: AQ5f1JpQpztIeYkLPuyW3dPC9qNjzMFZIVf1yPl5Behnw4HyZMKOCzFUOt58z3w
Message-ID: <CADXxVS+UQfrbWFfsDnW1QvkpvmEnkxMdv+OPBy=XpPXEFdcU8Q@mail.gmail.com>
Subject: [RFC] netconfig: Global option to send hostname with dhcp request for
 all networks
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Add global option to send hostname with dhcp always with
[IPv4].SendHostnameAlways so the first DHCP request will include the
hostname on first connection and don't need to modify the .psk files
to add SendHostname after they are created.

---
diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 4ba7b4e7..4f473e07 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -429,6 +429,11 @@ The group ``[IPv4]`` contains settings related to
IPv4 network configuration.
        will limit the number of access points that can be running
        simultaneously on different interfaces.

+   * - SendHostnameAlways
+     - Values: true, **false**
+
+       Always send the hostname in the DHCP request for all networks.
+
 DriverQuirks
 ------------

diff --git a/src/netconfig.c b/src/netconfig.c
index cd19217c..5959a5ac 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -375,7 +375,9 @@ gateway:
    }

 send_hostname:
-   if (l_settings_has_key(active_settings, "IPv4", "SendHostname") &&
+   l_settings_get_bool(iwd_get_config(), "IPv4",
"SendHostnameAlways", &send_hostname);
+
+   if (!send_hostname && l_settings_has_key(active_settings, "IPv4",
"SendHostname") &&
            !l_settings_get_bool(active_settings, "IPv4",
                        "SendHostname",
                        &send_hostname)) {
@@ -391,13 +393,20 @@ send_hostname:
        goto mdns;
    }

-   if (send_hostname &&
-           !l_netconfig_set_hostname(netconfig->nc, hostname)) {
-       l_error("netconfig: l_netconfig_set_hostname() failed");
-       success = false;
-       goto mdns;
+   if (send_hostname) {
+       if (!l_netconfig_set_hostname(netconfig->nc, hostname)) {
+           l_error("netconfig: l_netconfig_set_hostname() failed");
+           success = false;
+       } else {
+           l_debug("netconfig: Hostname '%s' will be sent in DHCP
requests", hostname);
+       }
+   } else {
+       l_debug("netconfig: No hostname will be sent in DHCP requests");
    }

+   goto mdns;
+
+
 mdns:
    /* If the networks has this set take that over the global */
    if (l_settings_has_key(active_settings, "Network", "MulticastDNS")) {
