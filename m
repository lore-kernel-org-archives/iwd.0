Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07E838F230
	for <iwd@lists.linux.dev>; Sat,  3 Oct 2026 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791047747; cv=pass; b=smVSdAZSGK4osoWwCOwR+6LLHqJF/p1ZEYLOLSA4I7gwuscmVSpu0sPAXeCObjCmoR6Lf1ws8z/RsSfDFVfOENlNDvyUtZNiP22ATRrx/cRvJHwMAQvetE5yKa0A8Dsk7A02nYQXYc8dRe3bNJwTrNgWibpZChydDnGULjshKEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791047747; c=relaxed/simple;
	bh=7xYw5hIvW8UZW1p53Mx19w1HyWknDoawHlbJmYELk7g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dJe9P0HInl26vxJuFl4CXnazyZe68Geu60vjffcrse/x/ftVfpURFpVGFgtxJomCE4yO7cRUCFl8BoobsxKOKXeHMQG1MOS3WQpd/E/80bRiyvDxGTjPMDH1nwmW9WQs5goZlMu5ihXq33IT4LWzGSyOFbeKdUfDLO9ha6B8kdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwiDXpTJ; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwiDXpTJ"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6aa8d04fcddso621765a12.0
        for <iwd@lists.linux.dev>; Sat, 03 Oct 2026 10:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791047744; cv=none;
        d=google.com; s=arc-20260327;
        b=DpYXAGIx56tzgtbE5Kes81KG8u5g4hKxYKcQx2/FXEU6zpqXXSc/iZUdVKzPa0batR
         6X9U6zy20FHKJbFjFMdNjMetNrM1KxTj01Mb/vucpyANFCXJRQL7BJi6jOY8e7CzhNSc
         XYarQOYC+Mcixt9flnu8Yvz8/ZQtvt101x67tsyseqj4c3NwUAEa6L+r/H+rSCvnlsyf
         6589ed6W/Puj4EPqv5DbzdJwHU0etHr/V4GQDYHBpp+Cr1myF3BR69SLfzM0300QPq78
         1eLDQ+tMs580pek6TNpxPzIv9gHhTFSpoKbkv8RxFwiVQ/MKoLQiYKCwlW4t60Y08ExY
         Z5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=RUePb5xCbAHwQ4uEyLEViZo011f7kLjE9hH4azW0RXE=;
        fh=LVwSdJJT2poHpWJpvI73c3fFqaJVA08Td3ZAiex6+kI=;
        b=pC8LjZplIhCkZkNH99vi8f/KrU0WZ73CpBEHJE1y/l0IffLQFLY2tSLeDXBznboKod
         8VRYY07wQA8YHJR6wLwo6vLsXBD+UasgmS3pu20OqRXwa0xe3MlFgMD/cBtlqMXdOBDR
         7HD44atjo4LNhuOqoEcb4Z1OXIz8R9UQng5jD0NrPd2gHc20MoOcxijGhrKqWQ4wB7Gl
         WVoTr7gFb/7yKXlSSDWTmiTnLz+xQbGofOZOkwg1UmwAY7MeMNr/2bV51SK04fL+qDE2
         t/RkFD5ARqnHlNIYE1hZ082BKCmKc5AoqWVBKvPthOTxBr0CEYOXyFUn/ZcATUn+nAI6
         YV6w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791047744; x=1791652544; darn=lists.linux.dev;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUePb5xCbAHwQ4uEyLEViZo011f7kLjE9hH4azW0RXE=;
        b=cwiDXpTJXSiiaQRGYg4XFiIcEZDWOW6KiV/vxSpT8+l5xSfAvszl/7ffnMUU/+PGw1
         6xyaeHq6g1sl9cyDLeVw7HCIVrNQQpcRVjHzkxZ/mXXxCrfOr6bMUAY3owbdAnllEB84
         QrSPgIrRxURa7R6EFR6wS5SazoKMgk5H5+D3P95m1Og+inqC703ai2w+5yJjU1E5sJ5d
         VJppWb2Xdt/oPvAtJscUvD0tVdeaFqnqPFPUtNKPBKOxC2dhfyq+nMvIlCqhPc6RXAHp
         rw94ULO1nuyO5KbI4fgAPtIxbPKnTDFeBmw/IWXIsbymU7Pc5OOlc2KanlVss/uEQrZE
         fCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791047744; x=1791652544;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUePb5xCbAHwQ4uEyLEViZo011f7kLjE9hH4azW0RXE=;
        b=gVEKo56Wkm1qeK+nQKfy95CL+DxoXciYUBuwBtASbHgTqWh2GqBAzVMCIv/64Y5jfp
         aVJ0uZ4L8nnzRuN1Ky1W/0CDkWEJBLC+h8/FYSPtBAVIn1Dzs8kpYFOQX1Z3MFkvwdFD
         Mza1qoME9tpamUOHvSnTuXX5xMafuKV5JnXtFry6yTDTgXBPRyhDoMiH37C9zTwQzA9Y
         wtGForyh/OvJps/dk86yGcAb/tCiWbayMM7P1ExTDbK3HkBqhDPZXIZv0I2LI+f/lylr
         gQeKHufv72uuMAM9R0NAyXrk0SaNqfBgc3nc8ZzrvOex5O7qvwxE5aEKgGW0my/lDuZu
         9qxw==
X-Gm-Message-State: AFq9FYIM/GSnvD6pJNubcXtfnjheDjh4Qb5mkVn6G4KXkH6oTi0LHoZi
	7FZG/G2Nu8H48TsajLQo29EAxujz9yg+5pfw6NXwaY16Pgp9oWOgJNVneBlTwP3lAyD6ZunhUl2
	sERujD70zMa8myy9IksrOUkrVwjL0j2YNp9/m
X-Gm-Gg: AYBFou0a+VC4ORxg0RUaf+G+R5sS2q8mlWc5sft8qcBa9bBEaaZ66r5m06FqRAcIMuf
	3/ud98iUGlCs6V1Qf9DckUuVPhjUbMnE3v+I9cnQkCDFu8AQjm2HHiNR0OthVvyhKo0QcdXAKrv
	yhHVE0f2WY653wSR04pLIDl0LHHJGTuCbRGRm6utHrJJlN71r2PhY5XqFplQsWDduB2NFvM1vjN
	ChNrjy5Q8hK+oEbSruBrNoKDokdFBrKTiYkeLUfZh14IRU5B3xMxmQZCqH27Qc2CqsIDto2T+ZD
	ckQ6ftApPWuAF/ilhGDVHxjpZaC4XOZjpZlxmIDlOoW2X69dCbEWqLGBQQ==
X-Received: by 2002:aa7:cd49:0:b0:6af:8b75:65c5 with SMTP id
 4fb4d7f45d1cf-6af8b7566ecmr4266783a12.11.1791047743579; Sat, 03 Oct 2026
 10:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Victor Rydegran <victor.rydegran@gmail.com>
Date: Sat, 3 Oct 2026 19:15:31 +0200
X-Gm-Features: AclHuK_3I4byLnaOyqwUQ16QMEVMSnVgFlWKYCkjhu7if8-U8v5iIMLR60sOdW8
Message-ID: <CALw60OpWr8cvA-z9Mkzc8WkiY11ioG0t1W9LR-xmj2BghambUA@mail.gmail.com>
Subject: WPA3-Personal (SAE) 6GHz connection fails with "Operation aborted" on
 MediaTek Wi-Fi 7 card (iwd v2.14)
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

After a recent update on Ubuntu/Linux Mint 24.04 (running iwd 2.14),
connecting to a 6GHz Wi-Fi network using WPA3-Personal (SAE) fails
instantly with an "Operation aborted" error inside iwctl right after
entering the passphrase.

Bypassing WPA3 by switching the router to Open Enhanced (OWE) allows a
connection immediately, confirming the issue is specifically isolated
to the WPA3/SAE cryptographic handshake implementation.

Hardware & Environment:
- Wi-Fi Chipset: MediaTek MT7925 (Wi-Fi 7)
- IWD Version: 2.14-1ubuntu3
- Kernel: Linux HWE 7.0
- Router Security: WPA3-Personal (SAE) on a 6GHz Preferred Scanning
Channel (PSC).

IWD Journal Logs:
okt 03 19:03:51 victor iwd[8596]:                   Max RX MCS: 0-9 for NSS: 2
okt 03 19:03:51 victor iwd[8596]:                   Max TX MCS: 0-9 for NSS: 2
okt 03 19:03:51 victor iwd[8596]:                  HE Capabilities
okt 03 19:03:51 victor iwd[8596]:                          Interface Types: ap
okt 03 19:03:51 victor iwd[8596]:                          Max HE RX
<= 80MHz MCS: 0-11 for NSS: 2
okt 03 19:03:51 victor iwd[8596]:                          Max HE TX
<= 80MHz MCS: 0-11 for NSS: 2
okt 03 19:03:51 victor iwd[8596]:                          Max HE RX
<= 160MHz MCS: 0-11 for NSS: 2
okt 03 19:03:51 victor iwd[8596]:                          Max HE TX
<= 160MHz MCS: 0-11 for NSS: 2
okt 03 19:03:51 victor iwd[8596]:                          Interface
Types: station
okt 03 19:03:51 victor iwd[8596]:                          Max HE RX
<= 80MHz MCS: 0-11 for NSS: 2
okt 03 19:03:51 victor iwd[8596]:                          Max HE TX
<= 80MHz MCS: 0-11 for NSS: 2
okt 03 19:03:51 victor iwd[8596]:                          Max HE RX
<= 160MHz MCS: 0-11 for NSS: 2
okt 03 19:03:51 victor iwd[8596]:                          Max HE TX
<= 160MHz MCS: 0-11 for NSS: 2
okt 03 19:03:51 victor iwd[8596]:          6GHz Band:
okt 03 19:03:51 victor iwd[8596]:                  Bitrates (non-HT):
okt 03 19:03:51 victor iwd[8596]:                           6.0 Mbps
okt 03 19:03:51 victor iwd[8596]:                           9.0 Mbps
okt 03 19:03:51 victor iwd[8596]:                          12.0 Mbps
okt 03 19:03:51 victor iwd[8596]:                          18.0 Mbps
okt 03 19:03:51 victor iwd[8596]:                          24.0 Mbps
okt 03 19:03:51 victor iwd[8596]:                          36.0 Mbps
okt 03 19:03:51 victor iwd[8596]:                          48.0 Mbps
okt 03 19:03:51 victor iwd[8596]:                          54.0 Mbps
okt 03 19:03:51 victor iwd[8596]:                  HE Capabilities
okt 03 19:03:51 victor iwd[8596]:                          Interface Types: ap
okt 03 19:03:51 victor iwd[8596]:                          Max HE RX
<= 80MHz MCS: 0-11 for NSS: 2
okt 03 19:03:51 victor iwd[8596]:                          Max HE TX
<= 80MHz MCS: 0-11 for NSS: 2
okt 03 19:03:51 victor iwd[8596]:                          Max HE RX
<= 160MHz MCS: 0-11 for NSS: 2
okt 03 19:03:51 victor iwd[8596]:                          Max HE TX
<= 160MHz MCS: 0-11 for NSS: 2
okt 03 19:03:51 victor iwd[8596]:                          Interface
Types: station
okt 03 19:03:51 victor iwd[8596]:                          Max HE RX
<= 80MHz MCS: 0-11 for NSS: 2
okt 03 19:03:51 victor iwd[8596]:                          Max HE TX
<= 80MHz MCS: 0-11 for NSS: 2
okt 03 19:03:51 victor iwd[8596]:                          Max HE RX
<= 160MHz MCS: 0-11 for NSS: 2
okt 03 19:03:51 victor iwd[8596]:                          Max HE TX
<= 160MHz MCS: 0-11 for NSS: 2
okt 03 19:03:51 victor iwd[8596]:          Ciphers: BIP-CMAC-256
BIP-GMAC-256 BIP-GMAC-128 CCMP-256
okt 03 19:03:51 victor iwd[8596]:                   GCMP-256 GCMP-128
BIP-CMAC-128 CCMP-128
okt 03 19:03:51 victor iwd[8596]:                   TKIP
okt 03 19:03:51 victor iwd[8596]:          Supported iftypes: station
ap p2p-client p2p-go p2p-device
okt 03 19:03:54 victor iwd[8596]: wiphy_estimate_data_rate() failed
okt 03 19:03:54 victor iwd[8596]: wiphy_estimate_data_rate() failed
okt 03 19:04:03 victor iwd[8596]: wiphy_estimate_data_rate() failed
okt 03 19:04:03 victor iwd[8596]: wiphy_estimate_data_rate() failed
okt 03 19:04:07 victor iwd[8596]: wiphy_estimate_data_rate() failed
okt 03 19:04:09 victor iwd[8596]: wiphy_estimate_data_rate() failed
okt 03 19:04:09 victor iwd[8596]: wiphy_estimate_data_rate() failed
okt 03 19:04:16 victor iwd[8596]: wiphy_estimate_data_rate() failed
okt 03 19:05:26 victor iwd[8596]: wiphy_estimate_data_rate() failed
okt 03 19:05:26 victor iwd[8596]: wiphy_estimate_data_rate() failed
okt 03 19:05:33 victor iwd[8596]: wiphy_estimate_data_rate() failed
okt 03 19:06:10 victor iwd[8596]: wiphy_estimate_data_rate() failed

Thank you for your time and help in looking into this.
