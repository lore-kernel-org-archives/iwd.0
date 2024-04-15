Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1C61553A7
	for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206867; cv=none; b=Pl5SkAAjA7lgLcnFNk2RQ2HAws8pivAaSSXQAtfVsyacsONlvuHwy2KDF/XnHuMkcW3WFJbBN7rIByglmUlJ4JXqVNeTNViqifXj85sfvZMGPN7IRbVKrgO3hBKpd/GXeoJM7vk1uZHY8EKp+Ln6/cCPK15puSXzmVAy3dL9w1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206867; c=relaxed/simple;
	bh=0dkcoKq/sUWgjLXwOx81OSMISfzBZeW0cjuJ9eEfz7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gOppP5JmhnCpHn8Xt3XypPkmkBSYPl1Fe5jzSX6gCXO9B/AYxrJKkf9xkGFnI6g3IY5AUKmHZmGFKdt0wFuAvQ3KvGB4mSN/t3MNzYDb9qEkEe9Jr7A6sZ3i4DH74yuEOBCSLbzsvoCG2R5piDKgUp6a9aswV9BBE0thbHdByLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+17WyMv; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+17WyMv"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22f01274622so2442224fac.1
        for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 11:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713206863; x=1713811663; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVRUHoUAFrLIjTU9ydJTkkcUdR/FZQZhBUgz4FfaQM0=;
        b=h+17WyMv+mbNtrDKkEG8OOeBUulIByQMdVY2Axf3wAUngXf7DR+i2fXhENUjMjdRPC
         XWcFCX2/IIU8hhaAghT+5YMO5KrUAbSX5WSsY2Q8NYUKibN10M9gCjgCKG+JIQLZV3L7
         fmNah2KJpRbUnpfTjF2WMn4D2Dl82IPiO4HMxEkp+d8uihf9yBcf+puKVrwNMWbq/c6+
         bCvZngECL0Gm9IA6ZNn+j88mQ4SH5Luu4iGtUqzNGe9yfbZTRk4tGY1xOQTjwkO8hPqH
         dzuaVxzPAquYFUuKAZwtsnENfu0n0wYFRpIm2fgNAgbDrEsUK+ajik2zLeOLqf6DaOCN
         uT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713206863; x=1713811663;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVRUHoUAFrLIjTU9ydJTkkcUdR/FZQZhBUgz4FfaQM0=;
        b=L81LOnXdm3UcWU/Ppa1SngFG+VkhfSSm5J/eC5l7ryQiGknAmaIiOL6RsYTCS5sCDd
         EbjwFhGoFUw120PNwbwyelyUYQnYIDpmOxrSi1sN0iXkPxom6hHqIL7oEWX7RZuq0nr7
         vmyC9C2HJwJeT2QFVw+wYE0/vEGAc+9Xy3dzC1D4ukABNYZyBQo1hOlNI7VR6rTthueh
         NoX+VIemiRugzBtlwH7oHgBedDn8o0te1jdVD3HiYIkIHs0Wd2IkT8hK/1ROsokubQZN
         NXkkvsqOHPMiiJSNAFK3wqC+3UE4HumQlRQ4fYXukuWuj9+WiDW5zZn574J4gGvhZr5l
         AFfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4Dyr/FJoR6MZspUW5y6/zNTTK5fkO0c2bCDFT/X8atK/znuIV4QZjzV+uKqi6FDQg0l9gmwZUur5/RvSOBZq/Vyfz
X-Gm-Message-State: AOJu0YxsaEBl1CMxI1cgucf8rq27Kr+6XV2yoZLUTRA9qDeiOuGlAviK
	tU6WvAodw3aE0VKOqnuzjwWJdQuDpDF/5zwa81tTZBHolUau4QXt
X-Google-Smtp-Source: AGHT+IHuAZ9YYrvohhzN61NkyjFJ9MugRcVgyN668xYVRbQ3yBzpt7PmqQwaqnY01xAZRgoEXa6IMg==
X-Received: by 2002:a05:6871:553:b0:22e:a970:a2ba with SMTP id t19-20020a056871055300b0022ea970a2bamr12375397oal.8.1713206863507;
        Mon, 15 Apr 2024 11:47:43 -0700 (PDT)
Received: from [192.168.1.22] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id vp8-20020a056871a00800b0022ea967bb9dsm2395573oab.50.2024.04.15.11.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 11:47:43 -0700 (PDT)
Message-ID: <873738bd-0761-4b0a-bbcb-cf76ea8f66e9@gmail.com>
Date: Mon, 15 Apr 2024 13:47:41 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] band: return -ENOTSUP when RSSI is too low for rate
 estimation
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240415151130.40389-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240415151130.40389-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/15/24 10:11, James Prestwood wrote:
> This was overlooked in a prior patch and causes the rate estimation
> to return -ENETUNREACH if the RSSI is too low to support the
> various capabilities. This return was unhandled and was treated as
> if the IE was invalid which then printed a warning.
> 
> The low RSSI case should just be ignored, similar to if the IE was
> not provided at all. In this case return -ENOTSUP so the caller
> moves on to the next capability set.

Err, why?  Just handle the error code.

> 
> Note: this does result in most of the estimation functions only
>        returning 0 or -ENOTSUP as they do little to no validation
>        on the frame, but rather just test bits. Additional
>        validation could be added in the future which would be
>        handled by this patch.
> ---
>   src/band.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Hmm, this set is failing CI for some reason?

Regards,
-Denis
