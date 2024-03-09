Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD64EB55
	for <iwd@lists.linux.dev>; Sat,  9 Mar 2024 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710019190; cv=none; b=DzgxLg26Ng0+5Fjos+wPaGN45eoQiRPPJ9RL/LqWt3uUCfsnexKVey8wyUl5dEHwEtituwJIGksX/3fBY0gwpdDStT9n3rbYX4kvX0Lx6uiMeVT8w6nNqqUDdWgxdPQFZDWZIMGdX1ok+HS8mp7gJe7/dazSZYGUUyesIuKB6tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710019190; c=relaxed/simple;
	bh=P3Kkd7Tbq2TwaZxyoiThJiXX8hEkLjRdhjb0zfVKDYU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bnp7VaxnrMjb5XrgHELxF3J7xMKeQ0cOqPkmNqABiVo5BqjB44gYVgFGgFhsxBAKXbOrkvTGn9w/xQ4ldkPpmLZY2IoyoUrDgpZaxeO6HXHR42SfudsHLxPSC8loLsisLWhDtiu/tdMY6oTaXLUIXV2HUxS7BW8KWtehnuHNhnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=0thHCN77; arc=none smtp.client-ip=195.10.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="0thHCN77"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4TsbLK2m27zDv6D
	for <iwd@lists.linux.dev>; Sat,  9 Mar 2024 22:11:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1710018665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xV8pj0GqQ9RHWrvUTx/mmALcASXGpR75DjWl/6COFfU=;
	b=0thHCN772BduXvTCYHJ4xyRyQY1gxMrXyxz7xyC5+SibDP2nIkxRMpmjuxEMcLEyQmDLDR
	TcIbCsmyJ5qn5vW9puPEfRiAzUYSAURx0Xc/Uk8/MkAXbAHkqFJu88OtyMDen67wSA9v4i
	I5m47UFMxL4NlpJoZ+u3JcL+IP09OZexFjYyELAms1NwVxod7ilug6hmcdo42eeEnGgDSh
	DJscj2dE63Z7UbcHlEEVi/8wBIGo/cAU4LYjCc3JCp45ac6YoaunOr/pfDSEQ47WWy0uCm
	F5bx1Xm1yGvOmS/BZRg+X2MabKq8HoOlyCAnku+ON7M4a2Acn3phl+AdRFxftw==
Message-ID: <07009e2a-3ad7-4a8c-bcbf-a665a19bd03f@tavla.de>
Date: Sat, 9 Mar 2024 22:11:03 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
To: iwd@lists.linux.dev
Content-Language: en-GB
From: Martin Petzold <martin.petzold@tavla.de>
Subject: Using bind mount for /var/lib/iwd results in zero directory (and no
 links) and no connections stored
Organization: TAVLA Technology GmbH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I want to use bind mounts for /var/lib/iwd. However, I realized that 
sometimes (quit often and reproducible) a connection is not stored (I am 
working on an embedded device and we are talking about a single 
connection). I also realized that the directory has size zero (0) has no 
links and this is different to my other bind mounts.

Just now I cannot test, how the situation is on first boot (early). As I 
said, the situation comes up at some time.

This is a fundamental issue for me. What is going wrong?

#####

$ sudo ls -l /var/lib/
insgesamt 76
drwxr-xr-x  5 root root 4096 24. Feb 17:05 apt
drwxr-xr-x  3 root root 4096  8. Feb 2023  bluetooth <- also bind mount 
with same configuration (files are written)
drwxr-xr-x  2 root root 4096  3. Jul 2023  dbus
drwxr-xr-x  7 root root 4096  9. Mär 20:44 dpkg
drwxr-xr-x  2 root root 4096 22. Feb 2023  git
drwx------  0 root root    0  9. Mär 20:47 iwd <- bind mount with same 
configuration (files are NOT written)
drwxr-xr-x  2 root root 4096  9. Mär 00:00 logrotate
drwxr-xr-x  2 root root 4096  2. Apr 2023  misc
drwxr-xr-x  2 root root 4096  3. Jul 2023  pam
drwx------  3 root root 4096  3. Jul 2023  polkit-1
drwx------  2 root root 4096  3. Jul 2023  private
drwxr-xr-x  2 root root 4096  3. Jul 2023  python
drwxr-xr-x  2 root root 4096  3. Jul 2023  rauc <- also bind mount with 
same configuration (files are written)
drwxr-xr-x  3 root root 4096  3. Jul 2023  sudo
drwxr-xr-x 11 root root 4096  3. Jul 2023  systemd
drwxr-xr-x  2 tss  tss  4096 30. Nov 2020  tpm
drwxr-xr-x  3 root root 4096  3. Jul 2023  ucf
drwxr-xr-x  2 root root 4096 28. Jul 2023  xkb

#####

UUID=09ad77a3-80ed-4e27-8014-aa7bde4da14c       /       ext4 
defaults        0       1
LABEL=system  /system   ext4    defaults        0       2
LABEL=user    /home     ext4    defaults        0       2
LABEL=boot    /boot/script      ext4    defaults        0       2
/system/var/lib/bluetooth /var/lib/bluetooth none defaults,bind 0 0
/system/var/lib/iwd /var/lib/iwd none defaults,bind 0 0
/system/var/lib/rauc /var/lib/rauc none defaults,bind 0 0

#####

$ sudo iwctl --passphrase "<password>" station "wlan0" connect "<network>"

-> Connection to network is up, but NO connection is saved - no file 
exist (however, sometimes it is saved. Maybe only at the beginning and 
then not any more)

#####

Thanks,

Martin

