Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F09313BAFA
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487424; cv=none; b=oS/rIzZzqEzy808V6TTjC6anNGbEXlwlvk4Wif36kQ8F7Qp2s6MUons/FXmkEXQjdjLLPkexNys9MxypUuzyzE3LbVCn7CyGDCfh7Qm0i6OrpGg/t39CwH6BXARjx3uk2/mXuszlUfzvi2COBm1iD+8r69ILs6rXR6IyN/hDIyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487424; c=relaxed/simple;
	bh=6Qx5jRIYWTZYHhXfy47i3AgbPsXvW/t+C0jg5UzEDE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ff7IZibaGJflwFfY9Aa8TStM8+AL7gkLqHPtOcTCh3TAc1IEi2d8HbEZuETlqhnCP4FdfdqdEZXjsY4Ma0o3mvL/2PwhCDDXR7xrOeq32T/8uyHQmpLcgG4HH1RzR2yyCR9mbQ1wWRRAWQd5KO33/sJKY8qbItTDh9I+FgG9CNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGbh1wjJ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGbh1wjJ"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so6427292e87.2
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 11:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723487421; x=1724092221; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Qx5jRIYWTZYHhXfy47i3AgbPsXvW/t+C0jg5UzEDE4=;
        b=gGbh1wjJdWSlTWAU15eRW2hFHr5pQw5Eh5apCFivbfFaiaPvg6pgX/J7mrWYibRped
         Bv9tnMgCT+M300VBsANW659nJ66zPxaO1ETOW+IAyxkeJ7b2Xf0X2XO/HXYK+4zkrlHR
         F7Tlz8a4RWbXbUdqtm4D9SE/F17ZgYpE/PwDR2X5H/rEFGLGmuasM69Fotnw/AahJ5IU
         kHB2zvbMR/0vE2OEF9Vl9aqOJq9qZInRA3IKsbXtPxfT5kCDeGxUEPMxL5tUITEhlntY
         fNqEYc74mFtb2hXOv3c+CO2gQxsjBC0vf6w4yovT4KBzUN+1RLFN+KMP6R2w9Y9Xrzkn
         D6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723487421; x=1724092221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Qx5jRIYWTZYHhXfy47i3AgbPsXvW/t+C0jg5UzEDE4=;
        b=RI3xJzHBIIG+iYWexyOOAWNPD4tCPLdjVSfQSbJHBQ3r94Npo+ELvaMNgJU22zLpVy
         6XfeCGhGiXbfIl2D/v2X5seg6fTAPOTTtel/r7Va/efPc/r950W/0BEcU4RQBnPTtb1O
         S5lPnjFN6Fj1j/KWBwOU1f5kgFf65eKn5jZ9Aw+eSmzmnFqEOiEZvJOOIHWwXLqY0HlV
         3sdX6OILEGhKm3aLa1y/jyihwnTtX8Gu5LbBnkaeSRvn75Q14b6IXg0rrfWQS+1aoUMy
         7vZ3VHC0karjU+/t5OtVp4bqkI/BLD+pUc18ExkrklvOe94/Rr7AUuPapQIH1rfhROMK
         qb8w==
X-Forwarded-Encrypted: i=1; AJvYcCUQzniGXZiEw+mRlFM2w8aKMTjJlMt0CZgyhLhF6FM6pZGB8nGDCCrrfU9ja/oh+fuxHd3m5pVQRetUrUa9f/EeiAEx
X-Gm-Message-State: AOJu0YwiMAQ6wBFEhLRxe+MGiQowU4EQ004h6MI6Sc3Zt2hjENKbX9bD
	XCLXTNh8SRO8kUimoeQkxJQMV6sukkD3OG67Ocueq7vEQ74lAkm6VXzJPw==
X-Google-Smtp-Source: AGHT+IFjMpa0smKkzVV+Ihc6G4/28nYEfsTDw8DC8euUUM9swPG9BUhQTdGpC069RJ6oNqt9YKJlGQ==
X-Received: by 2002:a05:6512:2243:b0:52f:d69e:bb58 with SMTP id 2adb3069b0e04-5321368120amr799891e87.44.1723487420622;
        Mon, 12 Aug 2024 11:30:20 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190ac8b9sm2344659a12.23.2024.08.12.11.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 11:30:20 -0700 (PDT)
Message-ID: <afbdadb3-af35-454f-8004-e5f2d891792b@gmail.com>
Date: Mon, 12 Aug 2024 11:30:17 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sae: support default group for H2E
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240812171649.163687-1-prestwoj@gmail.com>
 <d70a8db7-acb9-4d1c-8b01-0090c7e40cec@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <d70a8db7-acb9-4d1c-8b01-0090c7e40cec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 8/12/24 11:14 AM, Denis Kenzior wrote:
> Hi James,
>
> On 8/12/24 12:16 PM, James Prestwood wrote:
>> This was seemingly trivial at face value but doing so ended up
>> pointing out a bug with how group_retry is set when forcing
>> the default group. Since group_retry is initialized to -1 the
>> increment in the force_default_group block results in it being
>> set to zero, which is actually group 20, not 19. This did not
>> matter for hunt and peck, but H2E actually uses the retry value
>> to index its pre-generated points which then breaks SAE if
>> forcing the default group with H2E.
>>
>> To handle H2E and force_default_group, the group selection
>> logic will always begin iterating the group array regardless of
>> SAE type.
>> ---
>>   src/sae.c | 41 ++++++++++++++++++-----------------------
>>   1 file changed, 18 insertions(+), 23 deletions(-)
>
> Applied.  Do we have test for H2E & force behavior?
Meant to send that, its on the list now.
>
> Regards,
> -Denis
>
