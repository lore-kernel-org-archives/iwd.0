Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382667350C
	for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189743; cv=none; b=thG2UA7GRtJYuLTKsbI653Rt1xuH/Z67go0KBb/TVd1XX47PIlI/xEKjRAbs9QWa9Y+GHGja58b7iu4a/m2j4u3GURGLTrEyWiZ8L/kOsYV6t3Q1fjvrfCNVOA0u3js2cxbL8ETp8mRIwxljt5dktpY1hfjtzs0XX0nAJkGiarM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189743; c=relaxed/simple;
	bh=cVQaT+AZw/DuB/O+/xqR9Wd3OFS0FcUeI63oAW+fZqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HfDsakRk3CkcdyiSmYs5Qs0pW+P/N2sCPziqdjAwWTezLPOZch2vwE/HtI6qKzY1bI78SjN1DJPFt+A5TdwzaohcZh7TEhsCxVjwP5OWFm5tTzuUs8aJyqdIgkM9QKry5ppw9QpLeLfR6mNCH4jtwr+kGp95L2tHReR54hxxZ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZlE4FvD; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZlE4FvD"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78d683c469dso339919285a.1
        for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713189741; x=1713794541; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8aDeHbQpNwccqZkOOIMShnFHeiMyyvEorORnWqg4hxc=;
        b=ZZlE4FvDsnuCixIirxB9CsfKCMOm2/zM+izzDh9pDrF0TS6sQQOhtEFTfLhnX7Nba8
         1MvJSy7EZny8eYvyauulYkrriTFvm/q+3PtOUI80SlQAuISAYZyzp8SVflE/6mfvKFUv
         bmZWNOfvBKWvR9YXCg8jRNEMmu1w8czvOJyF59TPFhKkvPfIQDByi9gq5T2x2l0s3msT
         jdDDfLQVjHtOB8qwYdt/NEAhNZTlI3NBSth3yb2UGVDtDJIqOuuV+E81ovUzSYIxh1ta
         vz1FQXYqvHCYPRREsaGn6Svcq3YssDVi6s6MPU+Mi0zluY/HQsCJZER+KwNgDKeG8b0s
         N1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713189741; x=1713794541;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aDeHbQpNwccqZkOOIMShnFHeiMyyvEorORnWqg4hxc=;
        b=fQWd9+W6frcgYlUmK+/lV9NKw+8wfCErlFDqwgnphrnzjlOBG8l2d0kx0eckKE8N7A
         UJUqDDOTrF98F6UtjdW1Ah8BC/C6PZ9Dt0gyjgryY27WrtGChDclcYqnQksBIMGOSPVA
         125RA8/YrMWR04ZNOsecGBddV9Hn9BsOPBEw8dhur/tsQVjF/AGZjd7g8ApTLwRMvb+3
         WpSg2jy1t7uaLCYx1+WYhZXjFOQL3K7wj3D6ETkwtzs9Rbqf1mc2+TTod4OBEm5T8WGw
         mRLX9TH15ygzPd1oOUJL2KeFzjRvcxaSEfYMBu+9UFGuEBbn+FVcnQz+tdC3Gl/+KVvf
         vs/w==
X-Forwarded-Encrypted: i=1; AJvYcCWj8PEBqn1iNlRbYOXwYwEGw8mCe/wcYJjYjiFHvHN7bali4VfHnmAecH6cFwOO0AR3TeSOX/TAwZyhHIe852t0lctt
X-Gm-Message-State: AOJu0Ywi0OQlj6huJ/GYgQt+Xd8G4G367XhrCt6EJVUbYawkW1yo2ls7
	zr1DAwdj7yyZOxQa3hrx7Ru6rPJ4LyvSH0mWhWZ0XpCXBiak9J3xQGntjw==
X-Google-Smtp-Source: AGHT+IHXMcTh9dORlYL4/EzDc6X82DGDp0XQRar9nWgUEZ7jesn+ZPsy8zGyFrZse8zb0imSGUYIQA==
X-Received: by 2002:a37:ef13:0:b0:78b:e8d1:3ad2 with SMTP id j19-20020a37ef13000000b0078be8d13ad2mr10118474qkk.62.1713189741038;
        Mon, 15 Apr 2024 07:02:21 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id u13-20020a05620a084d00b0078a04882ac2sm6307433qku.53.2024.04.15.07.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 07:02:20 -0700 (PDT)
Message-ID: <a8fddf49-da5d-4fc8-9084-34b2ed40cd2c@gmail.com>
Date: Mon, 15 Apr 2024 07:02:18 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] dpp: prep for moving AAD within
 dpp_append_wrapped_data
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20240327151957.1446149-1-prestwoj@gmail.com>
 <ebcfd870-b9a2-4215-b652-3008d3d2b6b7@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <ebcfd870-b9a2-4215-b652-3008d3d2b6b7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 4/2/24 8:10 AM, Denis Kenzior wrote:
> Hi James,
>
> On 3/27/24 10:19, James Prestwood wrote:
>> The AAD pointers for DPP are specific to the frame type. This is
>> currently sorted out by the caller within the respective frame
>> building functions but its quite unreadable. There are some comments
>> but lots of magic numbers. This should be moved within the
>> dpp_append_wrapped_data utility but the first step is to make the
>> frame buffer continuous. This will allow the entire frame to be
>
> continuous -> contiguous?
>
>> passed and dpp_append_wrapped_data can calculate the AAD offsets
>> itself.
>
> I'm a bit confused as to why?  Whether we have an iov or a contiguous 
> buffer, the end result is the same, no?  If you want to omit parts of 
> the header from the wrapped data calculation, wouldn't you just break 
> up the header into multiple iovs instead?
>
I did this to prep for patch 2, which uses buffer offsets and the frame 
type to calculate the AAD data. Its true the AAD data is always broken 
up into header and payload but I didn't want to use iov's because we 
would then have to assume iov[0] is the header and iov[1] is the 
payload. A single buffer makes it a lot clearer: we can minimally parse 
the frame, find the type, and calculate AAD offsets. With iov's we would 
have to check iov[0] for the type, then use some offset in iov[1] for 
the second AAD chunk. This then requires the iov's be exactly what we 
expect, which isn't a great API.

Yes, passing the entire frame also requires the buffer is exactly what 
we expect but documenting "the frame must start at the action byte" is a 
lot better than "iov[0] must be the header starting at the action byte" 
and "iov[1] must be the DPP attributes".

Thanks,

James

