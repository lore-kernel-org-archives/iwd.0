Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25A1219F2
	for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYyYo/nH"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-58a0d0cdcc1so2049803eaf.1
        for <iwd@lists.linux.dev>; Mon, 13 Nov 2023 07:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699890496; x=1700495296; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvuh2VaBLbU8IQZzc/JV17iA/e04w8lzHkeJB4C237c=;
        b=lYyYo/nHfMrcH54BhVrGm+t3mP4d3FBL8b8K7ltPWh2vDb2tOxlfiFIoW5Wk5IWwre
         Uv88HyXrd7mnf+JbdqoHkwmFcfgOAuqIVaZJihxVqZnJ80uZY1AiHyv83vCkv8j8ITjN
         tQFvAFceLMeNgN0LwelzJZMan0s6439XozmBp94pB4oF0tYg7HKfDydvnZlCjX86sME0
         C/DmjcD8QH/8IPcKOmC9e+RxKME2T/gUCJs/ekQk6H+up5fIi9dzOl0wjTT/XU3d7/sv
         v3yiLiGr2obxd/bhh3y4Kjlwngjs6vcml2hpgAXPI6uF54GDwrR+N2fjMKZhjrqln++h
         Cyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699890496; x=1700495296;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvuh2VaBLbU8IQZzc/JV17iA/e04w8lzHkeJB4C237c=;
        b=DEayqI8pU83SYWojMqXbp8MUWvXAyQSsVqJlnQTlVU/j98CghB3WBmHgGdWBR5mjTq
         0kqUfX0YgBriFYqQx1fEMRgyBVOhvJc5cJrUNg651iaGAe33dWUqIcp2cXls8EGjBTfQ
         JRFwkFIQ/9YRkNQnkYeT8UQP38XXbHAGrXlpSLE21D5zqmMPm/Fcb772/12W2vXAY9WS
         8WE8DuovtwO3p5ZRGFh5fTkY58Fk/XAw+ECbdqPDdDxD93NKxeDmIxWlLFe9Yd6rA/FZ
         3hMXGvO8nYImMJ4L4atN3OejdFx5q+pyvI5jd6FBCwsKvaG72JTCE3J2LNKt+4SMi09/
         3OaA==
X-Gm-Message-State: AOJu0YyvaBrS/+r3EESxHFZCOtOgRU15illFckH0CYwdFhhkp1rJP6/s
	fIbc1EmKKIM35sLxuqTeYps=
X-Google-Smtp-Source: AGHT+IEAActKhf1if7Ol4yLrdvgnoiQ8+fntmeKM768FvP5YFLe8NVOISYF3R/Ps2pNws3ijaZQytw==
X-Received: by 2002:a4a:3910:0:b0:57b:63a6:306d with SMTP id m16-20020a4a3910000000b0057b63a6306dmr7370575ooa.6.1699890495978;
        Mon, 13 Nov 2023 07:48:15 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u5-20020a4a8c05000000b005840b5783a1sm999485ooj.43.2023.11.13.07.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 07:48:15 -0800 (PST)
Message-ID: <e4bcf71d-e8de-451d-955b-2d248c0d6cbb@gmail.com>
Date: Mon, 13 Nov 2023 09:48:14 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] auto-t: make test timeout configurable
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231113143255.278191-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231113143255.278191-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/13/23 08:32, James Prestwood wrote:
> With the addition of DPP PKEX autotests some of the timeouts are
> quite long and hit test-runners maximum timeouts. For UML we should
> allow this since time-travel lets us skip idle waits. Move the test
> timeout out of a global define and into the argument list so QEMU
> and UML can define it differently.
> ---
>   tools/run-tests | 12 +++++-------
>   tools/runner.py |  7 +++++++
>   2 files changed, 12 insertions(+), 7 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

