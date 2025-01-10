Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8D1213E74
	for <iwd@lists.linux.dev>; Fri, 10 Jan 2025 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736541381; cv=none; b=nHFD1WJpekNq3tOAtxZc9LetAZCBcHH+1dZKeGbaKCRBKm1z3YNk6YKHCvI0Bn9Z0OkwnECjX5QedSBhn+LJfwzdKQwJlPRXBh07h7lLyto8sE7JNEADsZNYCWW1mi9mkEuLFYG8udO9ikoQBpuqpdnyNB8Rh4lZTwuAmwJ+aws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736541381; c=relaxed/simple;
	bh=kq3XQaK06SnXsCTCzqK7QnSeHSRfQf3jM+hfG6p7/2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TltkuCO2ugFb1VgyNqxSbxI41OlDT0VBzVbF2Gsrl0tQOPzBjDJUrqIcPYfuDk9ZuqmPc2UMAxsVk3A2mRfxqfrJJ1BMn+ppbvuAMSGUSsvOfKA3elx6M+6AevzVhHdrANvrlURCnJY8ly1Be1mfR7CjN8m3kkqicrgffKSr2Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAE9/vt2; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAE9/vt2"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f4c111991bso1162945eaf.0
        for <iwd@lists.linux.dev>; Fri, 10 Jan 2025 12:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736541379; x=1737146179; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5P+7M7bZ/fSVF8c8Nu/G591/s1LLmIXYOmSM6Jvofrs=;
        b=mAE9/vt2MQHDKTOVfNd0QpvLV8HF55nQ7CqzG6cFi6baJTOm9CKbVDZVjnoRrvzxZZ
         YAKvl9eVISHoJn4+RU8PIlF9XmMWlPHJ8VxeJKBMP0GIEeBT6D1p4cuy3uSVOpRwkc0b
         +0QznvU1nWpdHotQopJ6vEF7USzetH26yepwzwHdOZiY7vhL8k9sdt/289b+kZoaDuuX
         unfKF+kXQ5mlwK85QMuaubbMhKUCUFHgOa33PTPbz/QyMPCQY2WnFb487anjbV4Txf4H
         +vf75mSWJla6OcbzWujsFRjqhgAYMrehS0m/KOqdGAx+1FCVAs2eLvrCDuppOeybulxb
         3l0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736541379; x=1737146179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5P+7M7bZ/fSVF8c8Nu/G591/s1LLmIXYOmSM6Jvofrs=;
        b=T5dmIuSiPs4R+Nfwms/YIzhvLwRcX5NLGkK5IN9ufIuAVSnCb3ScWKbYUXbmBp4o3k
         HKWhXQb/z620xSTKHYY9jT7V4iLAGDqpmf2jf6D7Y9EmM71Lp1VM/FMOflzz9H025Gq8
         LCWUk1gVocnm9dOcPLRhGcoLSuUyr3Td4aBYkTGsvokb8V94hNIN/+vsyr3xte6wJ4nB
         lo7gSEAni+2s/t4Ud82R2PLH3NYgyef7ibThd+LUNo6cmgS1bbnKjg3gpTq/0Wph0nmI
         4qr24/9D5AyGIpL5B8DUE66KBZsDUGf+dan79azO8sehWsvMLoCWzdIIlIjekNBrdqvN
         sokw==
X-Forwarded-Encrypted: i=1; AJvYcCX+QP983fgBWafmCSByr0umrS8wKiKv+Dk78R68B8na9Wt+MEL5eBVerbLt9MdVFbCNwZE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/xotivUzv5Am4WlrMOnxUTd3OLESfHGMhT6U6f/h+zbv2BRUY
	yNUfqN4i/h/Arm5ei9v4eNnLvtD0R5+8dNXfo4VLcOIxJzVOUwQ+
X-Gm-Gg: ASbGncu4VJffohiAhA5295lSFKLgzJjOp6BHD0AojxDqzdETGDffQ+degBxRyL+39ZS
	q+KszZdDmIvnjRhfJ9CrISvN6zdRmm6dMlSGDURpC/skVxPT3vsjkIb0/LrYin7XK147pPFkUtK
	AtPB9hOztrtruaSrZ4DF6Y8C3wvDaGDjfwI7Udg4g1tgd629IirJ7Yjaox1JeemHqvGXqSQKZKQ
	7sc6vjBPgBLUURdQ4I+eRT2yNums6JIJlS9j84kHUSUVq2mEk67duBzY0x2M5+PEK27S2tlwKJH
	Gv0csoKycAiBv9ra2ot21A==
X-Google-Smtp-Source: AGHT+IH1rRJPp7/32wOCQvpz6hVGhBOqwG47RFtCmOI1yNqqFizxbUuLGQFfiJWi4wYvpMxk6/evPQ==
X-Received: by 2002:a4a:e281:0:b0:5f2:b1cb:3efe with SMTP id 006d021491bc7-5f880e26798mr5013314eaf.4.1736541379024;
        Fri, 10 Jan 2025 12:36:19 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7231e6d39f7sm822055a34.53.2025.01.10.12.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 12:36:18 -0800 (PST)
Message-ID: <19782535-90f6-48cb-ad20-94f80cbb42b0@gmail.com>
Date: Fri, 10 Jan 2025 14:36:17 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TLS based WPA-Enterprise authentication methods on kernel 4.19
To: Michael John <MJohn@midmark.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <LV8PR08MB9350AF162B98623BB2E6AC85AE1C2@LV8PR08MB9350.namprd08.prod.outlook.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <LV8PR08MB9350AF162B98623BB2E6AC85AE1C2@LV8PR08MB9350.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

On 1/10/25 1:35 PM, Michael John wrote:
> Hello,
> 
> I'm running Linux kernel 4.19.231 (embedded, Buildroot build system) and when starting IWD I see the following message:
> 
> Jan 10 19:13:39 cm1sd systemd[1]: Starting Wireless service...
> Jan 10 19:13:40 cm1sd iwd[1537]: No asymmetric key support found.
> Jan 10 19:13:40 cm1sd iwd[1537]: TLS based WPA-Enterprise authentication methods will not function.
> Jan 10 19:13:40 cm1sd iwd[1537]: Kernel 4.20+ is required for this feature.
> Jan 10 19:13:40 cm1sd iwd[1537]: The following options are missing in the kernel:
> Jan 10 19:13:40 cm1sd iwd[1537]:         CONFIG_ASYMMETRIC_KEY_TYPE
> Jan 10 19:13:40 cm1sd iwd[1537]:         CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> Jan 10 19:13:40 cm1sd iwd[1537]:         CONFIG_PKCS7_MESSAGE_PARSER
> Jan 10 19:13:40 cm1sd iwd[1537]:         CONFIG_X509_CERTIFICATE_PARSER
> Jan 10 19:13:40 cm1sd iwd[1537]:         CONFIG_PKCS8_PRIVATE_KEY_PARSER
> Jan 10 19:13:40 cm1sd iwd[1537]: Wireless daemon version 2.17
> 
> My kernel has many backports and all of the listed options exist and are enabled.
> 
>> ag 'ASYMMETRIC_KEY|ASYMMETRIC_PUBLIC_KEY|PKCS7_MESSAGE|X509_CERTIFICATE|PKCS8_PRIVATE_KEY' ./buildroot/buildroot/output/cm1sd/build/linux-custom/.config
> 2475:CONFIG_ASYMMETRIC_KEY_TYPE=y
> 2476:CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> 2477:CONFIG_X509_CERTIFICATE_PARSER=y
> 2478:CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
> 2479:CONFIG_PKCS7_MESSAGE_PARSER=y
> 
> Even though my 4.19 kernel appears to have the required options I still see this error about missing features.
> Are there additional features that are required but not getting listed?

Nope.  See the logic here for yourself.  iwd invokes this check with 
L_KEY_FEATURE_CRYPTO:
https://git.kernel.org/pub/scm/libs/ell/ell.git/tree/ell/key.c#n791

You may want to strace iwd (or one of the ell unit tests, such as 
unit/test-key.c) and see what the kernel is reporting.

Regards,
-Denis
