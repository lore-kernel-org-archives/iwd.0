Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FBA374F6
	for <iwd@lists.linux.dev>; Sun, 22 Sep 2024 03:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726976105; cv=none; b=BmqbJYLco2jIC0y+SDVGoMpoaFk/7JdIkRlQLEOIR1EZhYtOf66uFrcpQjHVslMm9I1CS5h0gmneiA2uXwdcC8zSGdWz5uvsdO2Jd/7KzDTV56mTZz6oO0231xXky74ech9eTb26x3j4Z5mU0AJdzaGwDo9s/PMbRy8NsvrluG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726976105; c=relaxed/simple;
	bh=OxPvTQPKwNHLFD/tAkWiOWLHg1lPG4CLnaJm0sFFl0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=el8BF0WJtB1pRGBfJhRXwBTsPYTzUUKMiucZr+T6HCVAuaj/+BYlNB40SYS0KEpp04CI1S9jEltGIX3tNd58WYs4G0taQgC4aw7s/qZ0SGbFvSOlEK8T9tOFB15qmIdTUmEA1qJ+mgUhrhShoMOGtBjgdzVcMmkmAngwOcXJmu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABjBJPCW; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABjBJPCW"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-710d861eb56so1517538a34.2
        for <iwd@lists.linux.dev>; Sat, 21 Sep 2024 20:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726976103; x=1727580903; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+F7rc215brFVvAJq38o+U6Rk2VqNCS7t5RXAZay6IY=;
        b=ABjBJPCWFqrFcnoZvNYY0Z4SmIdTyikChhEv6zJ6lIlTZMG806mEtl+bLlyGP0h99w
         LQag0w7EviRaGxlB4g2RUgk5bl2+rJ2ZxQtnksEzIDa7MMy9MWAncNQ3Nqv48dR5KOQV
         XDnQh4Y/MMEUS6/dqIMhRa5B5X41eqq+R9/ZJd8G7KhbnYVbeoAj65omf3V5+yrJmwPm
         GDTI/2il2lipFxpUKoLe/WLNUlNbd1UPwIAp6jri5/sNchxTklOwNiwErWEwPSOo2UqK
         EuKP6/3lifMBofe8GJWhT/Lv8fz662rG8N/5TpTck9XB6VutVA7Gp9EwBDtM5CnQWMW3
         Gvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726976103; x=1727580903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+F7rc215brFVvAJq38o+U6Rk2VqNCS7t5RXAZay6IY=;
        b=EKneHD3y1vX0DYEP/aHkqpKbwB0eQnJDFuWYM9d8j9gSGoDmgJoEIgTlF9Z2kQNZxB
         5vWl3JCw/btJnhC4VFZAPCRdNKNUd8E527rJ+9RFV0bjH3IfglG7yFdBoq+naAOr51E0
         LLqBsGP0kmy124I9otLo3dndq70Mf1eY+LcZ33WOrye9uWKsyfmgnMCppayFlO07c7c9
         YVlVPQSnbZCss3Y6IWX7OSnSjphJy66ARBOBakRdwJoxm6nR2eSJ6jIUzxYigEKhRlHo
         mRfId+CWnkvJoC0ogd1nixXwvG6r0DuGvEQkn4TZKGTDLefN+/FOf+6Ny9T/aePw0QY7
         BVbA==
X-Gm-Message-State: AOJu0YwOSYG/Kvr0Dk48hl3ddgvI3LY4HkqA3du0P3m4OUIWVEMiz/uP
	IgBnCg0knnosx0WTguSqfaj095BuP7MDK0A4UZYUrnD7oS/UnXsg
X-Google-Smtp-Source: AGHT+IHF38SUx1H9WUUGVmpF9EPFCDMadjC3CXuMDOx4WgsknH3gj7YrwC1loF06xiMKl5QEKmew8Q==
X-Received: by 2002:a05:6830:6702:b0:710:f1fe:241b with SMTP id 46e09a7af769-713923af676mr5883570a34.6.1726976103029;
        Sat, 21 Sep 2024 20:35:03 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-71389bea323sm1503031a34.81.2024.09.21.20.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2024 20:35:02 -0700 (PDT)
Message-ID: <ba78a253-de77-4427-85c3-d876ef9fdd8a@gmail.com>
Date: Sat, 21 Sep 2024 22:35:00 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] External Auth support
To: Yuxuan Shui <yshuiv7@gmail.com>, ys3al35l@gmail.com
Cc: iwd@lists.linux.dev, arend.vanspriel@broadcom.com, prestwoj@gmail.com
References: <20240823174220.498594-1-denkenz@gmail.com>
 <20240921185902.170612-1-yshuiv7@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240921185902.170612-1-yshuiv7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Yuxuan Shui,

> 
> I tested this on an RPi5 too, and indeed I am having the same problem as KeithG
> as well. However I managed to get some debug information from brcmfmac when
> running wpa_supplicant. Interestingly wpa_supplicant gets the same -52 error as
> well, which it reports as an authentication timeout. But if I ask it to try
> again, it will connect successfully, and there is no external auth related log
> the second time around.

Yep.  It looks like wpa_s puts the resulting PMKSA into the kernel cache even 
though the initial connection using external auth fails.  I've only seen 2.10 do 
this, not 2.11.  Either way, it is a bug / lucky coincidence.

> 
> So I suspect this is a firmware bug, but it should be relatively easy to
> workaround I think? Basically we also add a timeout and retry.

It would be far nicer if the brcmfmac firmware + driver combination worked 
properly :)

Regards,
-Denis

