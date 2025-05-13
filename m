Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F81D5CD1
	for <iwd@lists.linux.dev>; Tue, 13 May 2025 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747145039; cv=none; b=dKlLH9vsz7+VNJ+pzsHU+Udk9/4WTwSid5B0jCSSI4a4QoXBO2OioecnOZHnJHjDrwllZ+VIrKRSccNIA2rUPg35tkOAQyXgtit74La3OvJVu6yS9LTUU250WLsqBd3b48XX5RG1WysS+XTU8dPJZFCpoIoCaJeFqikpdwsS3e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747145039; c=relaxed/simple;
	bh=zNU1NIcR+mxh0uAMBcOW0JdSObK1+f1hTWBbJCyMdWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJ60kV69vEJU6uFroUnbzu6cK6CMMn78L7/1GKwW/0E5zgx6i0BVjiL8msjBR3cH9J1rACkyKlc7NlJPnZQkeJ1u+jlUQPX0qgJzJ4R+IK9/hehfUU+58mOcb8P9mbG/f6WxMvPl1w9JJoNokvuWn2D+J7WUkuaN9klv+eCS0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwHo1phF; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwHo1phF"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2d4f832069bso2951217fac.3
        for <iwd@lists.linux.dev>; Tue, 13 May 2025 07:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747145037; x=1747749837; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aW5B8TTX3bVin0Mq8HXvLIsjm9fkCwp2j09ZBvJh1GA=;
        b=JwHo1phFTf5YoCmLoSTwhXkKb3dZSM3FHLljnpRtQrVf+83LLuca/xw9bNtIwmzwOZ
         roRFqwA9u0gumEj6MTlJ7ddgIxoCUVlcgbgCOiUO6jYFYIm6FRchgsdnGfqSkIpRIogT
         bIxb+JTNiLmqKbSLMaFSyMxAke3R0da7gOn4IQq0ORFN1+hm8OOnqyP2Yz7a0GLxSrY1
         jSJTn3u2NlbFyOEVGZ0xGCKH48LiIKE96oc3P3BmCTaBiVg/cWfcS3Jkmq62LsZKJQvh
         8tJffSNcHcZFSxBb/hZjgwcMARSV/1FkAfA5RDyH/2HXcUKuHb0qitg6MbORlX6XxrZ3
         jZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747145037; x=1747749837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aW5B8TTX3bVin0Mq8HXvLIsjm9fkCwp2j09ZBvJh1GA=;
        b=fwhD3mFPlYTbsP14DTPb7KzKhX3riTW4AYxWQ6c6a1JZBEAeQMa7rdHppsjEUYPYHV
         O65A9X2U5kQKcJyiWcg0U49kLO+TPaFDFUf9R3zs4z0Vg+YVA403svSUkytaRwcw16/c
         4W1Yqzvi36WjKV3sqURkRqo5BUwnEWEAyTtL8FGMz5A0ma/Nke/8Yb/9fFYWjkHHdvve
         ewc0c29vR/32mYXZAI8CQ9vgMgrDfsFjpyniCdLKHezJPjH/iaANG6hZJM4BNSVNbSVp
         +N0lzuPwknDbqfmKJo6Qd5iDep5Vy694oEeJnOMh7sauAKjnUSGL3+LRBGX2qPX/i3Zn
         o0wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAXCqI14Li9XTqvsL0oZ9MTzS4SAtKv5OywJQ5HUrrlP2fYswZIojcZgKqeHtVwyV+cqQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YzGDHOMiANMFblyCTxgCGmE/Y3jcaPgxEnOarHtdXOqGT3AQCak
	NdAL4rDVcXkm2nEKwOse8nq40M4yAtisy93kLIfnMyMMwLFqGxDh
X-Gm-Gg: ASbGnctiJpoeSfoegpJnFH7GvVCjJjZXsBAqrmA20SVJRxbW/pxhz/2GiZpqCjKMk2D
	vDsl5ZrffAM2uVEMakzEPnxAhABnNq2Pbq494wJwibEaUR8W8HvTXSgeviUFUw+fYHh9aXUqjbt
	1P6xnqGCIY9SjO9dVvnhz8Ub5FczZI6r73SNDRt+2TkN7XeowJov8LgHYzhDwe0Oowa9syEYY04
	w9DjNi5PUmlwx+C6uiqIgi+BhRzAkBu9snZcbgOIgCFg8ri8U73QnxlxwNjgl9Qw4E27Uokw3wy
	vWcybgeKurBb55V9JctRb8tMzls6YwLdEe5XphpvtwEF8LNjsxyjjYurVPMr1FgRQq7tEsNT47y
	pHmSCf0+d/4GBlcJY
X-Google-Smtp-Source: AGHT+IFTkYDjrtvLD5vmMkiEOxHVhw9cbcvARvdT4vUjXFb0TOS0ch27+iqfn1uyVsIieCCESgCueA==
X-Received: by 2002:a05:6870:9125:b0:2d5:1d1:8613 with SMTP id 586e51a60fabf-2dba434eaedmr9471588fac.23.1747145036627;
        Tue, 13 May 2025 07:03:56 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-732264dd290sm1924596a34.40.2025.05.13.07.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 07:03:56 -0700 (PDT)
Message-ID: <562c4ac5-088d-4bab-9883-1d4f8eca2b2a@gmail.com>
Date: Tue, 13 May 2025 09:03:54 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
To: Jan Hendrik Farr <kernel@jfarr.cc>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, iwd@lists.linux.dev
References: <aB30Ea2kRG24LINR@archlinux>
 <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com> <aB4HC8Iaa6wR5dj7@archlinux>
 <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com> <aB4hMsBfyawYatoj@archlinux>
 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
 <aB5onavenLymR-QJ@archlinux>
 <8a1c5172bc0fd9d2a33522294d1a2a4c4ceb313a.camel@sipsolutions.net>
 <aCMtCCYtNNl4dL5Q@archlinux>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <aCMtCCYtNNl4dL5Q@archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan,

 >
> There is a an SAE confirm sent by the AP. It's frame 170 in
> capture2.pcapng. It's also retried a number of times after that.
> 

What I also find interesting is that the kernel on the client side reports 
sending the Authenticate-Confirm 3 times (according to dmesg and trace2.dat), 
but only a single Confirm from the client is seen in the air trace.  I'm 
guessing the retransmissions (attempt 2 & 3) are lost somehow?.

[64414.164169] wlan0: send auth to 96:2a:6f:b6:d7:9f (try 2/3)
[64415.063575] iwlwifi 0000:00:14.3: Not associated and the session protection 
is over already...
[64415.063668] wlan0: Connection to AP 96:2a:6f:b6:d7:9f lost
[64416.215729] wlan0: send auth to 96:2a:6f:b6:d7:9f (try 3/3)

Regards,
-Denis
