Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9123B25A658;
	Mon, 27 Jan 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991263; cv=none; b=Ha5pYdH/BroqMOv6aPlmeA/SMmaRqLo32lbXZ6hDtA8FMqfje0/tH5UAfhAqyRFRCjIM2QIiHBYQyKd5uc383q0yBbhssp5BdS6Zz1J3p4sQPoJsoVyM6a/3lib62bNe0OxODnldE4pkJokq06fnU8MgZcfqb6NndXSBOEUGwgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991263; c=relaxed/simple;
	bh=P4YLS630pj+sIKngIzZXNX0CJaDfpIWSuim3VbvJgFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+dRbQVZqmtLkAeG35FqXHBPa/eK18RnR86ixsaHXYw8DqhxRWyC/FLy4GosWxjjVQt+61iPiTNsXfMZCfN0K4nmwV9Zp+6q++rmQ2Dhr/4dtaCENXRqscGNDsmfp8kn1ZfdGRoL0fukYNr5/Ze0r2wgFNZHTslUulxfdxfgLDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaWNrZfm; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaWNrZfm"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6e5c74cb7so403401085a.2;
        Mon, 27 Jan 2025 07:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737991260; x=1738596060; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iT8ApVhyv4PImzhWoKA6aW6GniXAQEVDWB5FBbwyYQc=;
        b=iaWNrZfmAXqiFjNBkV1kIvtDJFQ8plnLTHa0chOAQXCTmtRo3s7GUlOKPCiyZYFOxz
         mFcMg0XqL7wYzsgpUZKi64qNeo2TGbAHiexaNr7eFVJmV2ZKb02t7wTE1qh51sIUnItw
         6U85+insjz7cx6SrVm/QOe93bVhkMGEOLA5papqJ+/6amRP3OQ6xEar0GtM639qeGO2Q
         E72ZVlxvEpkcfUuj7EdmdEy9nAecdX3Cj+SjlTQeyRPDiYB4n6ZwARYBH8YyTzGyRfNN
         rK0/HMOeJI0e571Z6rQifloCWS0yr4lqjOD50RZAW5FXXAgElPz6eU3L84Fppv7ra4we
         YsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737991260; x=1738596060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iT8ApVhyv4PImzhWoKA6aW6GniXAQEVDWB5FBbwyYQc=;
        b=c93Ibl+WWmBSed0HIM9YBpK7ygYbELpsfHLEYqRp6B9a4kl+t2BPyOeaN0Tir2DjXN
         krFS8YR+zRpt5vt9TwrQy+qSVSm+Retr6uXdobAxMaEOEwT59ZUJNtQzIYVIgDoNBePU
         OODFKj4d03EG4Raj0/FY2H/krqnUHkGCwyyUIfOG1+HbLBLDhNJrHkqBrvqKQE5yOffS
         Blyi4olnAEYBv8JNdQXSMmTPUTI0paicg1sEqRZCAvxRjxOUHvZqrqWcQyADu2qbqK/Z
         IQfMOID+vC292D6VvBDcaGkinimVyONyPw9YmO4pV1tZfDzBv0ewBezsa9gPXaFWPQEU
         JmQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYVWRcviN5Lc94koDgc0zW3ipSlQAm6Y/TxCpEDiz8vBvYTfGHcHFXJJClAz7TuNhni33TnV2Z5g==@lists.linux.dev, AJvYcCX0rxjEIue0OaAirFiL9AmcKx64TSoEZIy2whEApWjQBExTN5KbLhkDZxjVv0VXjxBZqiV5@lists.linux.dev, AJvYcCXNOUmejQeuszJpazzG31bBnUjdKgZ9mELXrDM6m5jDVWiZGYz3HUIRpej/Xl1pW7VQbU2jomZO9cU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy27tFlbHkC6o3l31VllO/phgMAEHvP7dq7ZZtOWGPNnyuW6uZ4
	U/JY8BKJ/w7ISi0ahHx1OMxyic7TFQ6GcLGXIgwMymDn3GyZkhlE
X-Gm-Gg: ASbGncu5lK6Po7WI2kNkRGNXWx5jaNTmBHfOsNBc5SCiJos2JPGPPbkDyw9XIezAnz0
	pvLsw1FeiMjO8vyG8Dhz/oQKGAgiljC0obJOVefVb8F7YozCNwn4gi+tQeqDILZQJF/xoKD0khT
	7PswHf0IigQmILfYKliiElstX85yz88JOSXUVqk7iJWxq8jP7pQ42zi88VHFyPK2HSsJJuq9yvU
	jlZSB11rwyTktdNLFq6R9Gfo3CZCS12yI0iobUP15GHkPih0A5+hXFJoGM++P/zCqbUBef2SUOo
	45caI4Af
X-Google-Smtp-Source: AGHT+IEnJnp2cYoqDLWX58VIryul0pkwYiNqA2q/DFh580edzsdHDFRBVnOr5g0yz59lplOB/9utZw==
X-Received: by 2002:a05:620a:25cd:b0:7b6:d65a:d6ea with SMTP id af79cd13be357-7be63279052mr6779176285a.46.1737991260487;
        Mon, 27 Jan 2025 07:21:00 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9ae7ec43sm398710085a.24.2025.01.27.07.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 07:20:59 -0800 (PST)
Message-ID: <375f302d-7597-4880-96c7-e301e8c7cb4d@gmail.com>
Date: Mon, 27 Jan 2025 07:20:57 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac SAE/WPA3 negotiation - Part 2
To: KeithG <ys3al35l@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>, connman@lists.linux.dev,
 brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org,
 iwd@lists.linux.dev
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_Oq+RGOZpE+xa-CV8=VtmJu7G8GWxfVYqg1edEG9wC+yA@mail.gmail.com>
 <CAG17S_NdA9LdwmA_XfvPOVrhCdqp+BOtAssH0=RE-VSjg=WFnA@mail.gmail.com>
 <CAG17S_O6Bpc+JhhUuDvE70a+ef9wt9D7jG1gMJDNo1qZCUOg8w@mail.gmail.com>
 <194115affe0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_O7HbPFB0gubWWP9P-Oecps8K_LG0Y7YDo5DbNGKSLjpA@mail.gmail.com>
 <CAG17S_MwJC+h7O-htyUxEgB4zHKeGf+9B4QaQ6ZLiVStU_Egkw@mail.gmail.com>
 <CAG17S_NfqFjjaWj6vGS1HXux6JDy0QKcg8aQAR=aOzNGhO0a3w@mail.gmail.com>
 <eace9233-1b65-4793-8abe-abd3c640dba8@gmail.com>
 <CAG17S_MfQ+FjWQJoiNs30rt4u1O9Z_FXFB7BiS6RAQsG9ReNkA@mail.gmail.com>
 <CAG17S_OigLj3j=tS2BKYpoKOWKVs=XOBS-YFn26SzF9r+ZpLzA@mail.gmail.com>
 <CAG17S_Pj6UaA-yaGDUCwr8+M+L760PU0NvB1sAzGGNCp4xKatg@mail.gmail.com>
 <8c36a8c0-0246-4009-b79b-890e1f0a7aaa@gmail.com>
 <CAG17S_NNtyU0eXzsWgrjJEjcqDHPLrbSkvnEboSg-fZebdV3dg@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_NNtyU0eXzsWgrjJEjcqDHPLrbSkvnEboSg-fZebdV3dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

On 1/27/25 7:09 AM, KeithG wrote:
> I just tried this and it connected 2x once from a saved key and a
> second time from a new key.
> Will continue testing and let you know, but this may be it!
> Thanks so much for all the support.

Thanks for the feedback. If you continue to see issues with this 
configuration let us know. I'm probably going to just disable PMKSA on 
brcmfmac for the time being.

Thanks,

James

