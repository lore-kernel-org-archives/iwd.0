Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF52273F9
	for <iwd@lists.linux.dev>; Sat, 18 Jan 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737215570; cv=none; b=Ak/eKv0ioENWou+rdIbLjNS+07iJ2i1esju56GlZVF+DZZVtayn4mbOUM4R1bMoSfCtSsWRXbuhyLq9kiU4o9+SaQFcTC/YrjwHzlBZvyQMrCHl+1dJUoSE8NTT2gm5vBasfaesqHI65j8PKuJ5PJmHIqwCZ3SG0QZtNHMb7s8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737215570; c=relaxed/simple;
	bh=kFtT+QlXUGNxJx94o2mxV2gzjfAPQ4FuuzFBJz0ZPf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dRxcW5dqxPbV5FPs+msZahLlzw3a0SnrdgclP+C24SP2RRqZxNi+R8qkZp8NbKye5V7sJptMoC8CtzsLWgjbLp7C43378YlTILViNdRrszFtFU8GcQtf6FUFTQmO0KbuJeZrQSohRswk0OwZ7DQfEwWvl9K7lQO0MZKva6ZBrwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiAAryDk; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiAAryDk"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467725245a2so33915351cf.3
        for <iwd@lists.linux.dev>; Sat, 18 Jan 2025 07:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737215567; x=1737820367; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hcQQPcvZgaAAahduJ3e55R+SFsmYxTP6CAGzr0JqleY=;
        b=EiAAryDkRVhbMR+OxGSMr3MTHb1TdB5ta3Iu0eenQ9deGHurbkQRukPw22Eiv/Xpfk
         p/wnvpotwh0i6QUau83hbL41KzX+LnJ7YDzyywo3q6BpFk/rGn34Qi3ggNNnmrgxSwNg
         9aXw+KHiU4S0RF7rHfiEiA5aQW4Zt2NoYvHsAkdz3UH8zlUE4VIRbEoUGtUAI/bFJ+3c
         hutNCZ2kkMLN+/IQdaSdySFksxjWuMRbsjCfFkMyxfd4blypQS25rUGZF2bqjQ+YWXno
         Fupp4/aF4ZWpK6df7Kdqdyu7Vytbyip6gHPnd34KEkbFIgSmHGybcEupTXexEA8UJrts
         rMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737215567; x=1737820367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcQQPcvZgaAAahduJ3e55R+SFsmYxTP6CAGzr0JqleY=;
        b=iC9SGZah8hIn6dEFxGV5D23XYPs3vk+QzW4ECd8wX/nPsrE2xybpEC991wRnlr/OF1
         fnjqoArg9ApoaCHZrayr2AARxuIYQHe22qYIvOENBeOM4toB7kl9UPsFbo0LYsLGqQwp
         n23tfgP1jSG0jPk+v0YeBJoHJ2m9ZQapkP9g2324wplhzYIo8/6p1+M3Wfl0d9PKVHIg
         IwGU0icUkWtZnKXZFT6sFvZmnu/+QxOp1aUNiucts+EtSbuV+V8VbVAZGOF1+h3lG6yp
         K+fxbZLOGhSZg4F7D5lpJtR3m6z1J5l3HVeSWEYjy+oF9NGbXqwPBc5NxqyCq4JIPEQv
         82Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWRbCsimRC+qMfU9FWH0pcBYEiPCzHWxx7R7Z3h6CbN6KTe3l4IF/KTwXYKfuHtBmgA6Rw=@lists.linux.dev
X-Gm-Message-State: AOJu0YykAPcDYFbSceBGCO7iquprDrlwyl1rhNxTHK3kkaeg3IDnydnB
	Y9UILQLb08ATX7Aceah9JL/Un5u/Aay8vUZd2aY86YaU4owax7qd
X-Gm-Gg: ASbGncsp+SoieLezSOyTyGZDIxGlPT61GdskAyrc0GefEb5tc+/1waeFPamXPlxXbzd
	8F3UVUNw5bcTFyLmU3pFnw7+TT6tZLtOBubayirMI/0VtapxocwXn9bW98SLXTE9z7b3iHBTThg
	M42yrbhkKnbzWmgUTrbgVVa1m2ez5fN35VSTx2raawKg7l8dzC1Og/oKOViiC8GXLU91X5SfpfB
	93X7C/E9R/+j6kI4DFc961lgb5JJJpuvVhxY0CIwO9bcDCpIDc7NnxhVOt89o90rC3OuhqL1g==
X-Google-Smtp-Source: AGHT+IFakwTNfXp20cknvoydCMcmRztvEx0G2Zyx5VIvYrLKrNTfrYEiFhWRwH65i/XCvskawZ0ivw==
X-Received: by 2002:a05:622a:354:b0:467:5587:7c9a with SMTP id d75a77b69052e-46e12b7f5e9mr95681681cf.41.1737215567335;
        Sat, 18 Jan 2025 07:52:47 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e102fc639sm23558391cf.25.2025.01.18.07.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2025 07:52:46 -0800 (PST)
Message-ID: <60c1b2cf-95be-4a4b-9195-f141adf45a6c@gmail.com>
Date: Sat, 18 Jan 2025 07:52:44 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to triage an "Invalid Key" error message?
To: Christian Hewitt <christianshewitt@gmail.com>, iwd@lists.linux.dev
References: <345AE010-CAD8-4A38-BAE1-3BCD4930414C@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <345AE010-CAD8-4A38-BAE1-3BCD4930414C@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

On 1/17/25 10:03 PM, Christian Hewitt wrote:
> Hello folks :)
>
> The Kodi focussed distro LibreELEC switched to iwd from
> wpa_supplicant for our most recent release. It has been an
> overall positive change, but we continue to see a trickle
> of end-user reports of an “Invalid Key” error when devices
> connect to a network.
>
> Things we’ve established:
>
> * Reverting to wpa_supplicant allows the device to connect
> * Happens on a range of hardware so is not driver specific
> * Happens on a range of kernels (tested back to 6.1)
> * Poor signal strength shows the issue more frequently
> * Networks with FT enabled show the issue more frequently
> * Has nothing to do with passphrase length/characters
>
> TL/DR: We are reasonably confident the issue is within iwd
> code and not drivers or kernels. We also use latest or very
> recent kernels (and in-kernel drivers) and latest ConnMan
> (we are generally ‘current’ with upstream sources throughout
> the distro). We suspect a combination of radio properties
> (influenced by poor signal and features) results in an error
> which is not handled correctly so you end up in the wrong
> place in code and trip the ‘Invalid Key’ error instead.
>
> Our project team are not able to replicate the issue with
> our own devices and networks so we are currently reliant
> on end-user reports. We also lack iwd debugging experience.
> However, our embedded style distro packaging makes it very
> simple for users to update and run an image tweaked with
> iwd patches and/or config to get the output required to
> triage the issue.
>
> So I’d like to understand what needs to be collected or
> patched etc. to help start the process.

For a start if you could gather debug logs when your users see the 
"Invalid key" message. Tbh I don't see anywhere IWD itself would print 
that, but ELL will signal that if some IWD settings file is using some 
invalid characters, that's about all I can think of at the moment 
without seeing debug logs. Our wiki [1] has some additional info about 
debugging. I'd even be happy to look at any of your locally tracked bug 
reports if there are any, otherwise just send some logs this way and 
we'll take a look.

[1] https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/debugging.html

Thanks,

James

>
> Thanks in advance,
>
> Christian
