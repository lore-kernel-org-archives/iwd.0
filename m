Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFDC14F90
	for <iwd@lists.linux.dev>; Tue,  2 Jan 2024 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS9EXik4"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6dc025dd9a9so3596929a34.1
        for <iwd@lists.linux.dev>; Tue, 02 Jan 2024 09:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704214900; x=1704819700; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNh4yvD1bzFglnj8d+bf9McZ5zuC3iUI4L9It9PzS00=;
        b=KS9EXik4MkjLV2b+dobCwYEjfNxysFrKYKmAiaQRDa0yBe0fLMlzfAPd8TEfHRyHBc
         JOsA2UGsocFAfVH4kjcVABc33THZjOXQvD2TetEWl350hq54Wb31My/z04mz3OhxjZdK
         +3nnsWzz3NaW/XMd+TBGwI1+MCfbbKMxh5Jyo9iId04A1qFt0nLRpzVe5tOmhsZm6HwF
         yE2TCJNxqHLajVmp1Ra/QcTYNYxNANQE+QRHdofALGqsbczqjN74yhRT2cHsxpI8kmRL
         +LpOV6dj8ePGeI+egV6ZGkO8FEMXOu6wRL7NHjk30BiQd/gTTY/dZyFnU/aBmkEvSRPy
         2f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704214900; x=1704819700;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNh4yvD1bzFglnj8d+bf9McZ5zuC3iUI4L9It9PzS00=;
        b=hhrk+tIAxA7sP99yutTKjV2hRQjYjqoFzaZ+Q8zwDD0Gas96R9hnb35Z/FUJM19sfb
         615ro01EdBNkXQpRjli/b+MiWZmCCCc8oUIpW60sFdbaNIXm6kD5ydRWyYS+O/34AZbY
         XLIoTc+cbcOwatR/C3L6MnMZBxbueqEKekCN7QxxA7/cxiWDvP/5KT2PjviUTifTSnQs
         8zxZC/7rVag0Fa0h18rATjFBY0LJZ7MqnNAu3hs1Pr7y59tug7G2xAH6Nojj/gbWHvjf
         DRBHib45Y7qLqh2dAJrSMHNvjduudVHWD8ZpwB6RahSN+XzlEGWG5UqileFOSau1UZZM
         veAQ==
X-Gm-Message-State: AOJu0YxGwt2ZN9UUg2ZZrYI+CsuYoVasDGnpHekOYDcGE74vq1YWquYg
	5le8LxEDBpK+pLcU80r+H6WUAzKQ4w8=
X-Google-Smtp-Source: AGHT+IFuKIkY9xxG9PIgPB2gt7Wc8OBC5zm30LLjdUG4yHAirDhhB2Jp7cQqs1NL4XcOrfy53T2HBg==
X-Received: by 2002:a05:6871:606:b0:203:da41:b854 with SMTP id w6-20020a056871060600b00203da41b854mr22885737oan.14.1704214900162;
        Tue, 02 Jan 2024 09:01:40 -0800 (PST)
Received: from [172.16.49.130] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id pp19-20020a0568709d1300b0020472215893sm4363632oab.31.2024.01.02.09.01.39
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 09:01:39 -0800 (PST)
Message-ID: <cd1819d9-88aa-4441-b299-e2f9ec470a6f@gmail.com>
Date: Tue, 2 Jan 2024 11:01:38 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] monitor: Remove unused code path
Content-Language: en-US
To: iwd@lists.linux.dev
References: <20231227060954.103572-1-denkenz@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231227060954.103572-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/27/23 00:09, Denis Kenzior wrote:
> nlmon_print_genl invokes genl_ctrl when a generic netlink control
> message is encountered.  genl_ctrl() tries to filter nl80211 family
> appearance messages and setup nlmon->id with the extracted family id.
> However, the id is already provided inside main.c by using nlmon_open,
> and no control messages are processed by nlmon in 'capture' mode (-r
> command line argument not passed) since all genl messages go through
> nlmon_message() path instead.
> ---
>   monitor/nlmon.c | 36 +++---------------------------------
>   1 file changed, 3 insertions(+), 33 deletions(-)
> 

I went ahead and applied patches 1-4.  The RFC one still needs better support 
from the build system, so it wasn't applied.

Regards,
-Denis

