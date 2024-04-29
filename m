Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FACA141995
	for <iwd@lists.linux.dev>; Mon, 29 Apr 2024 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422333; cv=none; b=lODbJu2A4IkB8UafDNs5vN1mHvT/0WQSncwj73pKzJ2gV/AmkEtnYFQWW34bruE+4iBIuukPVzZJhOojyOtz0BG5yE/Pi4gEdNM7DKoVvsepvL1Qgr5qDsgTR2uLLHc/C0g/3rE4yCSot3Etkh/rNCrCHV7CQDQh65RWL+T2BUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422333; c=relaxed/simple;
	bh=yo9996hts2riUQTyfKPNsrIORWXql8nwHQLGaAjdoGo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jf64f+va+nphHgV13xtqOcZH22+qYPn9OgdopwcZ+4VZ+SUKuH2qbVkj7BuzUeZGBMCnctvMthDDemxOa3+++muUerg+/6jL/SZAByIwvXDex3RLZijfmnyNpHcZzAL3cR5DVw+eTPA6S85O0HYyrG1hjPH7qnsFKYFm49dP3OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WltsNaiB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WltsNaiB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41b869326daso24604415e9.0
        for <iwd@lists.linux.dev>; Mon, 29 Apr 2024 13:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714422329; x=1715027129; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N7nx2deqM0C9LivIuvD1j61mkd8Gagp0klr+zEStoAs=;
        b=WltsNaiBVCCwPoeoIB7KbklIknq2PwGD85lIZvZ4I4Qiqf+jWSiyirxp1IeLpi9Gs5
         h2XdWhhMZPHQYcVXloJd47aGC4DaVdaHvcBAexR2woN6rMQsAosmYarkY5WEN1P8o2xW
         f6y3U1rVuZYElJ7kUdIz7VDWAxvP1jX/4ftKoyHgeTcaJ8g/Rt/T5KOzpUAQACUVRONy
         B2wv3zoGeYINrKut5Ojok6VUdKX1Q+vEDPyxTnX8STxtGQUmmvQjZzRiaDFkg3IAkmQX
         9PvqFcxk95QOCS2NuJnW88Z8zbJbEaEb6AL/6fxe3VRIZzGzYBQVJTxgkkX4EX+Fk8iZ
         a+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714422329; x=1715027129;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N7nx2deqM0C9LivIuvD1j61mkd8Gagp0klr+zEStoAs=;
        b=fS8OkkKjtVe1scrkaL+uPpW2X5j/TRBWlrV+vduEC9KP2Rwt7j/Fp8ParpH9bJcmyO
         9798JPhFRJnyBfS3xR81nWOO0FFf7BQFkH+XfE7wWspFBTvVD/a7E/60cwrnUBtKBIzN
         wCz/JxgIdG/gAu6+YrM5lPIvLuambUwYDoHHN5qKY8lfkrW/NmFasp5SqfyQe68q2+DP
         hpQQxyoUFbPo1x7F5whs3lvoYo6l9D+5m03/EqLtN8+xZ+FxPO7hOR9hMCa/8lUUqL2X
         RutDYyQehq/U0hsuaucphMYNbDqQK+LR6qna549SGu+vPJCdLoMzSU6ivK1nk+cK/gUP
         eazw==
X-Gm-Message-State: AOJu0YyDIIQY432TCwGqR/2G8hTWRJtz/2bGT4u7K2la6PJTIEHHcvuT
	As+nTzMzagBkiamww6N2K9oODjFvc4wSbRVWoxMbUv+j/w7Lvpv2OL+KKpNa+2ZuoK33Hil4dZ0
	2T+UqdolsWCfsSs9h3qoxgUjLLQYaBNKg
X-Google-Smtp-Source: AGHT+IFpBg82CqrnK2OkIISFvI2YbY6aMR2zrJX6kyjmgJJxbBUGAP/gLANq0pD3S+AlvTYGrLBwI9zn3jZwh831lBM=
X-Received: by 2002:a5d:4566:0:b0:341:89da:540c with SMTP id
 a6-20020a5d4566000000b0034189da540cmr7679347wrc.26.1714422329253; Mon, 29 Apr
 2024 13:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Harry ten Berge <htenberge@gmail.com>
Date: Mon, 29 Apr 2024 22:25:18 +0200
Message-ID: <CAN+yObo7O+c7x51maXYxUiSttAC6ZJkuNb9DJwjCuegbAgyLow@mail.gmail.com>
Subject: Raspberry Pi 5 and WPA3
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm not sure this is the right place to ask for some assistance, but
here we go...

I'm the author for a small Raspberry Pi audio image that is
specifically targeting Roon.
If you're not familiair with Roon: it's an audio streaming platform
targeting audiophiles ;-)

Anyways, about a year ago I switched from wpa_supplicant to iwd, to
full satisfaction.
Better and easier integration, and overall a feel of me being in more control.

Now, recently I'm having issues with WPA3 support. This is partly
related to firmware (it's just so obfuscated how this all works with
firmware from broadcom and firmware from cypress :-(

And one of those things is that I can't get it to work on the new Pi
5. Specifically IWD reporting this:

Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
Network is WPA3-Personal...
Apr 29 17:41:41 ropieee5 iwd[275]: SAE unsupported: brcmfmac needs
CMD_EXTERNAL_AUTH for SAE
Apr 29 17:41:41 ropieee5 iwd[275]: src/wiphy.c:wiphy_select_akm()
Can't use SAE, trying WPA2

Now, the Pi guys point me to the missing CMD_EXTERNAL_AUTH message and
advise me to go back to wpa_supplicant. Which is not something I would
like to do for various reasons...

Do you have any advice for me on what I can do? is this
CMD_EXTERNAL_AUTH really related to  this and are you planning on
implementing this?

Thanks
