Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F13A41C7F
	for <iwd@lists.linux.dev>; Mon, 11 Mar 2024 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171300; cv=none; b=nZDQuVP4IBfsMwWywkeSZ/3t4kOXVm0sZiJNC6MqrRoW7jgi3I4ad5RTLZIHJbotUrFnzE8gukn3DSb06Zm4ly8ZnUhaAscQqvo9vpSYPrzmkXFUeTt/+u3sQjs/eOH7q0b32wzadfi4kCDYE/n9K5+PC7dyaE+yOfMdF1XC73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171300; c=relaxed/simple;
	bh=81u88DQblU4uBV+1EY63/YBDset7zZg/EQE8heqhRwk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Rcsi+GW9ezjdOJlKrEeXVPvCPJr+6RXLh3tUg5jw1L87S9ceNZx/dVscofJ35mpTk4Z9y9vfZoZY4fIj1yvsBW/KDG2j8SYCtDOBdYdAtTxUJptBkgHuLpUVoOOyhTyRq6OjyB2i0gku9vtCwn4N0FtmhEyPA0YcxI7bYS4ZarM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de; spf=pass smtp.mailfrom=tavla.de; dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b=NcVHfVt8; arc=none smtp.client-ip=195.10.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tavla.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tavla.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tavla.de header.i=@tavla.de header.b="NcVHfVt8"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4TtgbC6SBFz9vpN
	for <iwd@lists.linux.dev>; Mon, 11 Mar 2024 16:25:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1710170759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8nNvQQqt913tz7EW7TSdnb8aeKG9MtYld135M7ZM8g=;
	b=NcVHfVt8l+ctDS2ZRfqTccEGpnbrObZeMG3+ZPpGaonnOE4mYOfk/IFtinsjVH8Br+qr+k
	/dj8aOPG0H9KsvEX3RRQbNi2b/F6LjH03qdv0ploBngk/HuZLo8bDHvwGHOgUijXk22w0A
	ieElVt9JLOS5rJT1w8oNMwvwTRl9LvF91azsEMImJnEaRIIotxSFj8TBqH8aR4h7G5/TPA
	xDfuALl465LkRog9+gIIOoK7uGds5onHOZCe/IMyfBdDEVHngAmVDblzXJw6xhgtb3lJb6
	DAxbLxSN/nenAjLRnupP9FfDJKOBW+5383IWR/mfmcGkqfDmqk/4l9FaTUw5zQ==
Message-ID: <26f4ecf5-2f67-43f4-b197-9caea5ce9319@tavla.de>
Date: Mon, 11 Mar 2024 16:25:58 +0100
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: Using bind mount for /var/lib/iwd results in zero directory (and
 no links) and no connections stored
Content-Language: en-GB
From: Martin Petzold <martin.petzold@tavla.de>
To: iwd@lists.linux.dev
References: <07009e2a-3ad7-4a8c-bcbf-a665a19bd03f@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <07009e2a-3ad7-4a8c-bcbf-a665a19bd03f@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Maybe it is a bad idea to delete connection files while iwd is running? 
Or should I do an iwd restart after deleting connection files?

Is there an iwctl command to drop / forget ALL existing connections?

#####

Anyway, it also seems to be a bad idea to delete the underlying bind 
mount directory (/system/var/lib/iwd). I switched to only deleting the 
content of /var/lib/iwd with /bin/rm --recursive --force 
/var/lib/iwd/{*,.*}. However, this only works as root and not with sudo 
because of limited permissions on the iwd directory.

Some more system information: Debian 11, Kernel 5.10

Thanks,

Martin

Am 09.03.24 um 22:11 schrieb Martin Petzold:
> I want to use bind mounts for /var/lib/iwd. However, I realized that 
> sometimes (quit often and reproducible) a connection is not stored (I 
> am working on an embedded device and we are talking about a single 
> connection). I also realized that the directory has size zero (0) has 
> no links and this is different to my other bind mounts.
>
> Just now I cannot test, how the situation is on first boot (early). As 
> I said, the situation comes up at some time.
>
> This is a fundamental issue for me. What is going wrong?
>
> #####
>
> $ sudo ls -l /var/lib/
> insgesamt 76
> drwxr-xr-x  5 root root 4096 24. Feb 17:05 apt
> drwxr-xr-x  3 root root 4096  8. Feb 2023  bluetooth <- also bind 
> mount with same configuration (files are written)
> drwxr-xr-x  2 root root 4096  3. Jul 2023  dbus
> drwxr-xr-x  7 root root 4096  9. Mär 20:44 dpkg
> drwxr-xr-x  2 root root 4096 22. Feb 2023  git
> drwx------  0 root root    0  9. Mär 20:47 iwd <- bind mount with same 
> configuration (files are NOT written)
> drwxr-xr-x  2 root root 4096  9. Mär 00:00 logrotate
> drwxr-xr-x  2 root root 4096  2. Apr 2023  misc
> drwxr-xr-x  2 root root 4096  3. Jul 2023  pam
> drwx------  3 root root 4096  3. Jul 2023  polkit-1
> drwx------  2 root root 4096  3. Jul 2023  private
> drwxr-xr-x  2 root root 4096  3. Jul 2023  python
> drwxr-xr-x  2 root root 4096  3. Jul 2023  rauc <- also bind mount 
> with same configuration (files are written)
> drwxr-xr-x  3 root root 4096  3. Jul 2023  sudo
> drwxr-xr-x 11 root root 4096  3. Jul 2023  systemd
> drwxr-xr-x  2 tss  tss  4096 30. Nov 2020  tpm
> drwxr-xr-x  3 root root 4096  3. Jul 2023  ucf
> drwxr-xr-x  2 root root 4096 28. Jul 2023  xkb
>
> #####
>
> UUID=09ad77a3-80ed-4e27-8014-aa7bde4da14c       /       ext4 
> defaults        0       1
> LABEL=system  /system   ext4    defaults        0       2
> LABEL=user    /home     ext4    defaults        0       2
> LABEL=boot    /boot/script      ext4    defaults        0       2
> /system/var/lib/bluetooth /var/lib/bluetooth none defaults,bind 0 0
> /system/var/lib/iwd /var/lib/iwd none defaults,bind 0 0
> /system/var/lib/rauc /var/lib/rauc none defaults,bind 0 0
>
> #####
>
> $ sudo iwctl --passphrase "<password>" station "wlan0" connect 
> "<network>"
>
> -> Connection to network is up, but NO connection is saved - no file 
> exist (however, sometimes it is saved. Maybe only at the beginning and 
> then not any more)
>
> #####
>
> Thanks,
>
> Martin
>
>
