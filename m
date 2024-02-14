Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FC55FB8A
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928001; cv=none; b=c7/rimHUstrVq/OLgHyTS3OQgR6qYsCaQgyArBWOomhTBaOlziPM5Nu4s1Kou38tb/JspNEnr4d2aZt2LlVTfn2GEL6gUrmS7+Uvv6+OTONjIW+UGp7vTC0fSbCqC7pgMufjh0LQxaXdhdJ/lKwSvHGxg4/V2YvSjv7oH1/Xkoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928001; c=relaxed/simple;
	bh=l/481r1umMIBH6cpV/4WUQg6qDkaQfHUoGKAEKwbXYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yi+lp2rC7QxtyrNfAAFGLFmUOUp2tpY1ghVSFTbsYJjJvvSjQ7a2VpxliuBHcuP56y+C/BN/l16ApRZwcY1PWW5d5ukeAB3GAXF3HPnKE8TIf4BxDMI3d16GxsKoMOqtrVlv51O2Y6ep6o/6ssNJ/Dds6TPngGYnOItM7JLiWaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKNaiBpu; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKNaiBpu"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c0467b94c6so1121118b6e.0
        for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 08:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707927999; x=1708532799; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvekIIenUcgZGsq6MZj9i155//zQ/n/U9TiB9c16mbc=;
        b=hKNaiBpuqC/wgJ/SzREBEFbKhkaBXT0EuMKEbOebvjSLNFIDf3MkxgGvfAEAt1kzqI
         5hoMlOsJQd9Z4AvUG1patIQy1shENzOgk+/3Myf6gfX7zCzjFTT9q17qXrSavWEFq+c5
         uOSY8hxs2/98jXEhYvPs7k/NutY68dlNEO7ol3+2aiEeHyeMhVVPVhImQAU9mTtbO8Fu
         FKfFssdfGWZX6UxMwZYkRy52l4AHspqU1i6vix50n7Xt2S3uCLdXGuYZjTBjeveY7O1t
         HlHhMrYhBQ57OjZVn1A0mVHpxbKJFT06U7sAeQBDghwZcyNW/ZbvmxtsOhKrl4BzbiwZ
         l4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707927999; x=1708532799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvekIIenUcgZGsq6MZj9i155//zQ/n/U9TiB9c16mbc=;
        b=Ysb7V6/jkiW4a6Apapl40oOsyhl5ubKuC38Z6UaG59DRJGHTY4nJu318iALSo06h0x
         ZKoYwjDmSZXQLzRtXDk2IaMlv/w4pPmnftBhIa1bHKfF48qtrLALdh132olUPiDUWpns
         J1IwXBbFE2w26g33pex8M/vyvsx9MPHORq3u/tK5fa+sayUpK6mNNckw1DKtfrL0pkzP
         F5PKECMNP8jytGwd6288JPTKS6zH6VX8OJjqWW0zS2V2HX8y+K2Z5CoSYF8IqfmOL062
         tHsdMXYFM4NQjWUyR/Rc4KvzILrDJYGznenu7aisb1733rx4ZrdYk5BcP/xOEx7yohde
         wS1A==
X-Forwarded-Encrypted: i=1; AJvYcCXoJvhJer5W5yLZO1xpfC1PTclexrTu4PUZQhWzX1LGp9DZamtcSxuk7wna7+sEeL5baUWUKAo5n+rESIPoLv5srPj+
X-Gm-Message-State: AOJu0YyX77odXg1UfGsiB0bkeTmxXIeKEwPEPytk9Akdh8ForDIqzcLK
	JcIibHrGKQem5/EqyLA0cl6xMbzOgwL+s9yE2qlsUL40Vlx9UrcQ
X-Google-Smtp-Source: AGHT+IH4WRZB/+a3rnpClFFKBBucYLnvsBB9P0KxFZ8VrTcuTiIdKn9BGnU21Nf6TSVNYf6gEfIjeQ==
X-Received: by 2002:a05:6870:a2d4:b0:210:b61d:7b81 with SMTP id w20-20020a056870a2d400b00210b61d7b81mr2851943oak.38.1707927998673;
        Wed, 14 Feb 2024 08:26:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/E/nLy1tvYqIDtKR2T/cCZGzbvcjFAZvHzM+ntOwtXM9bPRqVMopzfEtDGIJ0xx5lHGEixT6cGW4O92m53B4do4nP
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id la4-20020a056871410400b0021e17b6f410sm161970oab.44.2024.02.14.08.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 08:26:38 -0800 (PST)
Message-ID: <f9970105-c1c7-484b-8e13-5ca5f5bae901@gmail.com>
Date: Wed, 14 Feb 2024 10:26:37 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wiphy: include libgen.h to fix implicit def. with musl
 libc
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Clayton Craft <clayton@craftyguy.net>, iwd@lists.linux.dev
References: <20240212184747.30422-1-clayton@craftyguy.net>
 <8b02ff06-9c2b-4503-8fb8-9784c2628394@gmail.com>
 <152B8E7F-C6D0-4827-AC38-25454FD6BAF7@holtmann.org>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <152B8E7F-C6D0-4827-AC38-25454FD6BAF7@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

On 2/14/24 01:03, Marcel Holtmann wrote:
> Hi Denis,
> 
>>> This fixes a runtime segfault with musl libc and GCC13. musl dropped a
>>> basename prototype[1] in string.h, causing GCC to define it implicitly
>>> with the wrong function signature. The correct basename definition based
>>> on how wiphy uses it is in libgen.h.
>>
>> Hmm, why did musl do that?  man 3 basename indicates that the libgen.h version implementation is free to scratch in the input argument, while the string.h one doesn't.
>>
>> In this particular case it doesn't matter since driver_path is never used again.  Still, the string.h version is much more intuitive.
>>
>> Maybe this should be re-implemented in missing.h or ell (say l_file_basename or l_dir_basename) instead?
> 
> we can also just do a l_util_basename that does the right thing and allocates a new string from it.

We have l_path*, so I guess it would be l_path_basename.  That would work as 
well in this case.

I only see two instances of basename() use in ofono / connman, both in 
src/log.c.  Given that the only real user is iwd, I wonder if we should just add 
l_sysctl_get_driver() API instead?

Regards,
-Denis
