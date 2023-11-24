Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6342C364A1
	for <iwd@lists.linux.dev>; Fri, 24 Nov 2023 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOCbUvo7"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b2f507c03cso1175338b6e.2
        for <iwd@lists.linux.dev>; Fri, 24 Nov 2023 09:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700845776; x=1701450576; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/8bpuE/Cr5rZQed9hBsXLuDk8apGVR7zrbWXQ1j3pU=;
        b=dOCbUvo7WlFKCEczd4GmqQkw7f1KpSw8V4tGNPbCB7+lyci0a78j1+rrHbDdKtv3ZF
         DeYrXrlRKwuvp6ceulhXhlq/X1oIxLTtJ9cpgDLKMmXD7fob4/BHmXpmm7prr+CopHcT
         1E46Km4s2xwyOq6OnXipBq25HiHBXwqkXjq9fHLm6DJXbGt7X8gE0TZ4qvuwDSeT+/Wo
         8MLqWEjfpI7imthre3v/5KiVsfDWPC8UEaxI2KMjYROTQb79KjyT0CdVHFu4AX6zzrg6
         GUcuYGICpzhErRJbRaQH4akvV0JiDmAqmftBfeQhJLbWGj/8/oZTXMbhp3DpqGsCiCTR
         BGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700845776; x=1701450576;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/8bpuE/Cr5rZQed9hBsXLuDk8apGVR7zrbWXQ1j3pU=;
        b=nlfR9GjMTKEVZzP06/CHKQrx8L01iUvaXWo8JFX+GK/Z5tFD4dr7naCXu0sN6bfgnO
         1P6JtllE4t9svDkcGcYv7McweIc6j+1tifo4OgT1b46DKtoA08hz4rROq7mSGbpBokO4
         VR1HkiGEdFJB1EFvkpcwMI9C9JVE7hQzbEg0CcFnmcrOZu/QfuSnAKW98zpjixIMUvI5
         E+JAImw9ZsO5qnGieomfG62kx79AUvRR8BSRLwlXB0eK84GoaHmbHL2Ey3yXx941C6pv
         wDswEjbYmgEwUF9OJEb4EZ6R5WSjqBkvSrEcyruvr2sdrQrbkogbqE1Mbrd67EaQ8oBf
         Q7zQ==
X-Gm-Message-State: AOJu0YyNnxQK90k5u4b0WksFCn4I3EF14626bVc1ytyxDukhjN/o8ks7
	3Jd3wJo+yZlrexdaZ2YfBvND0chThyg=
X-Google-Smtp-Source: AGHT+IExsCaijo4IRzoYhX7Fi53jnEzSSSWPa3exXKZXu01IfJPbKxWbZ1MgIB5q5sehEvCWIzZqXw==
X-Received: by 2002:a05:6808:bc4:b0:3b8:3e9c:af97 with SMTP id o4-20020a0568080bc400b003b83e9caf97mr3533458oik.48.1700845776370;
        Fri, 24 Nov 2023 09:09:36 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id t21-20020a0568080b3500b003a78d196acasm554982oij.32.2023.11.24.09.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 09:09:35 -0800 (PST)
Message-ID: <c3854a08-c529-46e2-81ed-29cd4046de4f@gmail.com>
Date: Fri, 24 Nov 2023 11:09:34 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Wrong source MAC for DHCP requests with
 AddressRandomization=network
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 iwd@lists.linux.dev
References: <87fs0ve52l.fsf@toke.dk>
 <0d1aaf1b-09b3-48c9-82ed-fa3a46cc56b2@gmail.com> <87plzzhz4g.fsf@toke.dk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <87plzzhz4g.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Toke,

> 
> Yup, that resolves the issue so that I can connect. However, this is the
> DHCP packets I see when moving between two networks (back and forth):
> 

Excellent.

> 
> 17:49:59.040639 1e:aa:ca:6d:0d:e0 > 92:0a:9a:27:ca:65, ethertype IPv4 (0x0800), length 342: 10.42.3.52.68 > 10.42.3.33.67: BOOTP/DHCP, Request from 1e:aa:ca:6d:0d:e0, length 300

Looking at the timestamps, are you sure this isn't a DHCP RELEASE going out to 
the old network?  Enabling DHCP client debugging might be helpful:

export IWD_DHCP_DEBUG=debug
<start iwd>

> 
> As you can see, in each case, there's an initial unicast request that

iwd should be sending a DHCP release when we start to leave the network.  Maybe 
it is being sent at the wrong time (after we queue the CMD_DISCONNECT), but it 
should never makes it out to the new AP over the air since the client is stopped 
once the disassociation is detected.

> contains the old MAC and IP. Which seems to be a bit counter productive
> if this is supposed to be a privacy feature that doesn't leak addresses
> across networks? :)

Definitely.  Can you provide more detailed logs if you still suspect this is 
happening?

Regards,
-Denis

