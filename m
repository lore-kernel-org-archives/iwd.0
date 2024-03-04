Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24D15D1
	for <iwd@lists.linux.dev>; Mon,  4 Mar 2024 04:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709526728; cv=none; b=AQnzun7oJSvcId/AeuH/OXrlZeoh4n/0DbM93PxibRVf6z4Su402scOdt3ZEs7i84dpFUgIcZQV4v23KuoXI4+oK4pqHcYq9KENWPgEFeWGOsVWfw6RjFthj0hySZ0E0H6PESHNO1VjYHAdwhIwPLGS1+v1HzAr+TTjfR2Uw7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709526728; c=relaxed/simple;
	bh=bzSg+r1kothYdOm4Sv2TEQgvoN8E4VPC2QoyveyWW/0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OVZpNKIY9PVat9mYTLgaRT5PImo6lr4crBVnzxmtj5ePHCSFv4AIQhIV0vpggvMcTSoseJG27/wT8Pi5AaOKlyGKwOOv8PhQ63d+tqE7upGynIDfkiZgSPoOWMh/Pm2AQge6eQUul+Eyj/S/b6+fmCctcViwbtY3ZTc17n+ZLMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejfFlF/I; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejfFlF/I"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56682b85220so6453024a12.1
        for <iwd@lists.linux.dev>; Sun, 03 Mar 2024 20:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709526724; x=1710131524; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QHkQMF0d/S7fLCFBEHcnFXhZQcWSUeVdBpUXFzTNfnQ=;
        b=ejfFlF/IVA8Bcp8SEo6jLpXSpPqisham9sqkRwBIPtdpBWM7zoWrW2DlHsxm5LYP4w
         zA0w81uegz2B2wRoS3i1fOjftjGMXX9Esvga1NGZqT06sdKHXwcqCbxaEp4pE6ngKb+f
         oFlGNK0g/LQ5jtX7PsWBYrO7EAyN9LCNwza5e20RYmPFyfjkQxW9NsDee87MTY1NHtu4
         xYkrTXpJXmKhs2Hid/f70FFsQeez0M0Vk0rHb8DNNExQ4qe+xXjGWwnyy68x5HvGKwRD
         w6SSZV9E2Sf+UUKZVYbC7FL1AiryHDSUPCKHiCtp51CprCprbbZLw3usviyXjwYQmDnA
         v66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709526724; x=1710131524;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QHkQMF0d/S7fLCFBEHcnFXhZQcWSUeVdBpUXFzTNfnQ=;
        b=Dxe4O7ES6/0qEDvKW8l/Ue37MWruDznaoa8dg74HEyNTZHu8vIotGxXIhL6wB0feHF
         p1AIbRALvdwCA+RNuaPUx7ovlfmWeM8ZpU3ROjT8QwM2pSEyBsWcx+WH9MtjyS3UuUD9
         HFdVEXKgoOVMqsP0kmjBDudXgBoOFkQpyoHotiImnJVms72FWMyeSG1mmeaOPmpNBSkt
         R50mhHfN+DNp5bNvah/ySTDDqMLduWwa+FOxGEKAtvv42qsW+kNXMWBQ377PDNf421Z0
         2UKI1s8NKwVRs5fVh+CorZSwoNa8ISoLCdPHfAh9qhVz0WwOQjW76X82cqWnElAwAJZc
         Sohg==
X-Gm-Message-State: AOJu0Yy5yYO1VqKg7T2lyHFNbOHoYisJhhimWtj5Q3QNOJ7B8PGM5WEF
	f0EcPCYN9NkcRXB3WxlD9FTap+OpCy5lIjCf/vt2TWua6R2pXAWXg83We2F/KK3dL6KaXa4NE38
	+9GOiDVLo/tqxgVQ5TdPi8WrsYmBvQXM7fqI=
X-Google-Smtp-Source: AGHT+IGMRCkX5zdps8i02Mc1fQlnpAzxk7ADT6O7xaeBZwvg19d2EfSMCF2pZ7kW6fi/vPFjmdkAzdHE2bVZy44aUtc=
X-Received: by 2002:a17:906:b80b:b0:a45:1c4b:54eb with SMTP id
 dv11-20020a170906b80b00b00a451c4b54ebmr1725553ejb.3.1709526724206; Sun, 03
 Mar 2024 20:32:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Kentaro Yamaguchi <kentaro.y@gmail.com>
Date: Mon, 4 Mar 2024 13:31:53 +0900
Message-ID: <CAKbf6axbkp5E1M8Pvm1SbPOQFtzxX8Cdwj9YjbYNy0aekHDHzw@mail.gmail.com>
Subject: How to connect specifying the BSSID?
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Dear iwd users and developers,

With mesh, I would like to check whether it is faster to connect
directly to the child device or the parent device.
Therefore, please tell me how to connect using iwd from the client and
specifying the BSSID.

According to the comment made 5 years ago at the link below, there is
no way to connect by specifying the BSSID.
This has been answered, but is the situation still the same?
https://bbs.archlinux.org/viewtopic.php?id=237074&p=5

I tried the following, but I was unable to connect due to an error.
I know that using wpa_supplicant as the Network Manager backend will
work. However, in that case I would like to use IWD because I have
problems with 6GHz connectivity.

1. Specify iwd as wifi.backend of NetworkManager and restart.
2. nmcli device wifi connect [SSID] password [Password]
3. nmcli connection down [SSID]
4. nmcil connection modify [SSID] wifi.bssid [BSSID]
5. nmcli connection up [SSID]

Error (from journal log)
-------------------------------------
Mar 01 16:38:48 livazplusNetworkManager[1408]: <info>
[1709278728.5365] device (wlp4s0): Activation: starting connection
'Buf-MLO' (019cd427-8f11-4c84-9625-db03895b510b)
Mar 01 16:38:48 livazplus NetworkManager[1408]: <info>
[1709278728.5367] device (wlp4s0): state change: disconnected ->
prepare (reason 'none', sys-iface-state: 'managed')
Mar 01 16:38:48 livazplus NetworkManager[1408]: <info>
[1709278728.5370] device (wlp4s0): state change: prepare -> failed
(reason 'none', sys-iface-state: 'managed')
Mar 01 16:38:48 livazplus NetworkManager[1408]: <warn>
[1709278728.5374] device (wlp4s0): Activation: failed for connection
'Buf-MLO'

My environment is below.
--------------------------------------
Lubuntu 23.10
Kernel 6.7.6
IWD 2.8
NetworkManager 1.44.2
Intel BE200
[    5.297551] iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ
Version: 0.0.4.125
[    5.302086] iwlwifi 0000:01:00.0: loaded firmware version
86.fb5c9aeb.0 gl-c0-fm-c0-86.ucode op_mode iwlmvm
[    5.764947] iwlwifi 0000:01:00.0: loaded PNVM version 8443a58d
--------------------------------------

Thanks in advance!
Kentaro Yamaguchi
