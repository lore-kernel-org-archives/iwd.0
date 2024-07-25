Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A601741FE
	for <iwd@lists.linux.dev>; Thu, 25 Jul 2024 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721924127; cv=none; b=K1uWlkL0j3K0PzCSCbmwdOllMDy3Vu/mNUb5pOywZLCVqiaHuSlxRAza7rZ0MH4pKqy+VORG2/v6R+FuAVZAfgiRPy473cv0lkDCOMhMRaC1DhZyT58/FQU2dtlxYivmdoNNZDLciWVU7cHvQzn9elEpcD/AulYtmCCzBU6N1xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721924127; c=relaxed/simple;
	bh=r+s87XIrs4NJtmXJitDDMjuafNy80iKTwm9lGxmdvIU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pcatgKA4V+UzNY1mfBgss9tF/J21MuMFKHBgUCuEo6digUVJnIWW9YHIdlWANvBnLPlrbq5LGu6eYMCdIgLoV4e7Er9e58FJj1y5SkPHSF0/QniAeWvvWerNe7NI5S7wfniU+YY8eucThoEaUIVSdQKh3eXiO3ogneJ4i6pzCZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhkwF0lh; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhkwF0lh"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7036e383089so18177a34.2
        for <iwd@lists.linux.dev>; Thu, 25 Jul 2024 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721924124; x=1722528924; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hLaqKd6tM4ABh3fsHkpSrSeHNdjMypwEllJDhvj4oV4=;
        b=XhkwF0lhTAzW83NU60neOxOoCFODjsPK+9aAHuS07oyZvj4IGKPpouX5EPMJivThI1
         nwjR9DgbrPqWYp9K5Ste18gCajgWzbQIRta4SlasnC8LCQp1RwVvLD9uQ6Um1S17SD2A
         LU1egLKeA0JC2MHpaLnzMTpEfgnwE4mlqxCKGlDuHbIhSy2gbtppT4PuQFVgwJygE/9V
         bMP7ADwe1RvBZGYmTi71h/7uoB1BxzwngdXLA08gN4sumcvbgUoS0DUbxZgRZNNsNilm
         EkvJzB7QUL1iSoWowYWLuELkwg21y0roOcQ8ygyMwxLS2rjjoj7WgtmuIoE9R3dlQQhe
         BzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721924124; x=1722528924;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hLaqKd6tM4ABh3fsHkpSrSeHNdjMypwEllJDhvj4oV4=;
        b=te8hMsLJ0r1dEhU7CGa3l0bh90sEFnhq9sI64Kc/2nZt9j5uNIZ1swBEJ7rLvVy9Lo
         BIbC3ZNgBhSGrsLsVcOmDgTlzxbbN9amTgCnd02JWLsDxjingXIhwLFMxJLWOyDJ9Di2
         eL18z70PQePMB8GAF7+pkkRBnyRnCmkUywjfKxPNYCAKcC2yXCQ51Nj+P4/LGLFykcoj
         6ZZrZoPeVDrfFh9nZKJULi8pom4zbq0n8DgFbZcY4cYlfahZxDFkkSspslxQoW+WS107
         N5ogKtCrjqEo28tgDqfMxE2BY18YtbwaLbWYpO3iiJ3aLQwv1yQQb19R2G3rdTGtkPDO
         69ow==
X-Gm-Message-State: AOJu0Ywyi41Bi1cJ5iGch3Jd3HIAvzOY8ZCFk3aptI8vrnPACjelZ00k
	r+JS/VEU6w3rMALozr/UGS6Laqwon0kH9dCqBscTB9Y8CqVNCcIjf1Kp05Hc0qieaTeHIeruY/l
	9+eMB16DJFscuH6f76/NobkigizVYCf7lCWA=
X-Google-Smtp-Source: AGHT+IGI5E6k4k5dAV+ULZwwFvXsmqLY/+YpdEPHMSmGLT+9GnXhJ1F2f7vf60u0zMh8KcXLJ1ykgkGh/Fo22vPDhnc=
X-Received: by 2002:a05:6830:2110:b0:703:68ad:315b with SMTP id
 46e09a7af769-7092e752b4amr3604024a34.24.1721924124030; Thu, 25 Jul 2024
 09:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: daniel antoine <univac55@gmail.com>
Date: Thu, 25 Jul 2024 18:15:13 +0200
Message-ID: <CA+iibzCB-6wXch6yFu-4V9dKgz0sJRopsd7wXchccptT5hNB-A@mail.gmail.com>
Subject: IWD CMD_SET_CQM failed: Operation not supported
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi

I always have this error when iwd connect. It's not a problem, it
works perfectly. How to get rid of it.

juil. 25 17:35:05 grat-os1 iwd[530]: Wireless daemon version 2.19
juil. 25 17:35:05 grat-os1 iwd[530]: station: Network configuration is disabled.
juil. 25 17:35:05 grat-os1 iwd[530]: Wiphy: 0, Name: phy0
juil. 25 17:35:05 grat-os1 iwd[530]:         Permanent Address:
50:c2:e8:0b:58:bd
juil. 25 17:35:05 grat-os1 iwd[530]:         2.4GHz Band:
juil. 25 17:35:05 grat-os1 iwd[530]:                 Bitrates (non-HT):
juil. 25 17:35:05 grat-os1 iwd[530]:                          1.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                          2.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                          5.5 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         11.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                          6.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                          9.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         12.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         18.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         24.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         36.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         48.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         54.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                 HT Capabilities:
juil. 25 17:35:05 grat-os1 iwd[530]:                         HT40
juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI for 20Mhz
juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI for 40Mhz
juil. 25 17:35:05 grat-os1 iwd[530]:                 HT RX MCS indexes:
juil. 25 17:35:05 grat-os1 iwd[530]:                         0-15
juil. 25 17:35:05 grat-os1 iwd[530]:                 HE Capabilities
juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface Types: ap
juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
<= 80MHz MCS: 0-11 for NSS: 2
juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
<= 80MHz MCS: 0-11 for NSS: 2
juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface
Types: station
juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
<= 80MHz MCS: 0-11 for NSS: 2
juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
<= 80MHz MCS: 0-11 for NSS: 2
juil. 25 17:35:05 grat-os1 iwd[530]:         5GHz Band:
juil. 25 17:35:05 grat-os1 iwd[530]:                 Bitrates (non-HT):
juil. 25 17:35:05 grat-os1 iwd[530]:                          6.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                          9.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         12.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         18.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         24.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         36.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         48.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         54.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                 HT Capabilities:
juil. 25 17:35:05 grat-os1 iwd[530]:                         HT40
juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI for 20Mhz
juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI for 40Mhz
juil. 25 17:35:05 grat-os1 iwd[530]:                 HT RX MCS indexes:
juil. 25 17:35:05 grat-os1 iwd[530]:                         0-15
juil. 25 17:35:05 grat-os1 iwd[530]:                 VHT Capabilities:
juil. 25 17:35:05 grat-os1 iwd[530]:                         Short GI for 80Mhz
juil. 25 17:35:05 grat-os1 iwd[530]:                         Max RX
MCS: 0-9 for NSS: 2
juil. 25 17:35:05 grat-os1 iwd[530]:                         Max TX
MCS: 0-9 for NSS: 2
juil. 25 17:35:05 grat-os1 iwd[530]:                 HE Capabilities
juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface Types: ap
juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
<= 80MHz MCS: 0-11 for NSS: 2
juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
<= 80MHz MCS: 0-11 for NSS: 2
juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface
Types: station
juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
<= 80MHz MCS: 0-11 for NSS: 2
juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
<= 80MHz MCS: 0-11 for NSS: 2
juil. 25 17:35:05 grat-os1 iwd[530]:         6GHz Band:
juil. 25 17:35:05 grat-os1 iwd[530]:                 Bitrates (non-HT):
juil. 25 17:35:05 grat-os1 iwd[530]:                          6.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                          9.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         12.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         18.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         24.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         36.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         48.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                         54.0 Mbps
juil. 25 17:35:05 grat-os1 iwd[530]:                 HE Capabilities
juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface Types: ap
juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
<= 80MHz MCS: 0-11 for NSS: 2
juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
<= 80MHz MCS: 0-11 for NSS: 2
juil. 25 17:35:05 grat-os1 iwd[530]:                         Interface
Types: station
juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE RX
<= 80MHz MCS: 0-11 for NSS: 2
juil. 25 17:35:05 grat-os1 iwd[530]:                         Max HE TX
<= 80MHz MCS: 0-11 for NSS: 2
juil. 25 17:35:05 grat-os1 iwd[530]:         Ciphers: BIP-CMAC-256
BIP-GMAC-256 BIP-GMAC-128 CCMP-256
juil. 25 17:35:05 grat-os1 iwd[530]:                  GCMP-256
GCMP-128 BIP-CMAC-128 CCMP-128
juil. 25 17:35:05 grat-os1 iwd[530]:                  TKIP
juil. 25 17:35:05 grat-os1 iwd[530]:         Supported iftypes: station ap
juil. 25 17:35:05 grat-os1 iwd[530]: udev interface=wlan0 ifindex=3
juil. 25 17:35:05 grat-os1 iwd[530]: udev interface=virbr0 ifindex=4
juil. 25 17:35:06 grat-os1 iwd[530]: event: state, old: disconnected,
new: autoconnect_quick
juil. 25 17:35:06 grat-os1 iwd[530]: udev interface=wlan0 ifindex=5
juil. 25 17:35:06 grat-os1 iwd[530]: event: state, old:
autoconnect_quick, new: autoconnect_full
juil. 25 17:35:06 grat-os1 iwd[530]: event: connect-info, ssid:
Livebox-XXXX xx.xx.xx.xx.xx.xx, signal: -45, load: 6/255
juil. 25 17:35:06 grat-os1 iwd[530]: event: state, old:
autoconnect_full, new: connecting
juil. 25 17:35:06 grat-os1 iwd[530]: CMD_SET_CQM failed: Operation not supported
juil. 25 17:35:10 grat-os1 iwd[530]: event: state, old: connecting,
new: connected
juil. 25 17:35:10 grat-os1 iwd[530]: event: roam-scan,
juil. 25 17:35:12 grat-os1 iwd[530]: event: roam-info, bss:
yy:yy:yy:yy:yy:yy, signal: -49, load: 1/255
juil. 25 17:35:12 grat-os1 iwd[530]: event: state, old: connected, new: roaming
juil. 25 17:35:12 grat-os1 iwd[530]: CMD_SET_CQM failed: Operation not supported
juil. 25 17:35:13 grat-os1 iwd[530]: event: state, old: roaming, new: connected

I have found one commit referring to CMD_SET_CQM it's the commit
2dc785982d29ebd72b7cc6ed5548454f386ce222  netdev: Check
EXT_FEATURE_CQM_RSSI_LIST before sending CMD_SET_CQM

Best regards

Daniel
