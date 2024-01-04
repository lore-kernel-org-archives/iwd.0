Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C0228DAB
	for <iwd@lists.linux.dev>; Thu,  4 Jan 2024 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrBz1OJQ"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-204520717b3so398165fac.0
        for <iwd@lists.linux.dev>; Thu, 04 Jan 2024 09:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704390974; x=1704995774; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=957EudI7W0apKfNeTLz2Tul/rGstEinH4almlhykECw=;
        b=lrBz1OJQLRzSMu4wDYGV/umElaDfgSSFWDi1ysfXdL5PX9VM/KkE/SQVjFGxgoeB5/
         4yg3zywnsLvmgnymIWQrrW2oh0KINBqR6er5QWt3iLWUSPkc94JQ4yd2lkhNmlBdWgrF
         nprPCFT5Tm3I1Yx1dqZ1IlZHS4t2cqk8CxX7kHOvHqkYavG+TTx1v4dI0AgQrspcVGqs
         FekC+HMaPHFRpaMLyrS02pKpspVwNLZtSNIVcgzOjBfB06BZzl2vAXUSXXBn6w8v9j0z
         cGyMPSbwdQK7+EwAWU3tvq9Hm1B4hZMzwXywN7nt2G/MTpSx76ayFa299diAvdh/aJhU
         yAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704390974; x=1704995774;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=957EudI7W0apKfNeTLz2Tul/rGstEinH4almlhykECw=;
        b=cUs3iYePormBkFBRLxm3jsve2594UA1dAkhlmooO+N84j0s4v59mMDmN2/ml6ih4Za
         rjy1Zk7zd+l8OnmLC7DrH0DHEGyPcA3hBQZgmYTHYM6TdW2Ii6IU7nqvuGPkpTjkPwOV
         M8j+3NKhjb6FO8ayQXvhlOv3X6JYfIlF6P6H4ZsFgAAk+VvANvwe9QEpF0yvUOcKVJoD
         nhM05/0HCBT0FRfLJjXU8aQoVHsi3TcordiVw7TQHaVA0mzh6eRbmztXbQ7mNBKeCWAw
         limZXC5orTYviT37kiDKsKr8xx784RVA08IzaidmHY05J+r2tkv7qPAOqBHUTNsYYdcJ
         MFAw==
X-Gm-Message-State: AOJu0YyGmB+bhXGKJOztVlxm029WmO6JR/qPrSX1SyM0kD+O1rGy8dD8
	TgAy5Jzs+1FaNw+M7WdMvvvsRBGBb10=
X-Google-Smtp-Source: AGHT+IF6uweCJp1kUkmLzHqSo+GX0yoobTd/hlBxcPAI+BeZ5iy6uZSaC/C9hWDMsTeqZPMSew++1w==
X-Received: by 2002:a05:6870:ef13:b0:203:b690:eaf1 with SMTP id qq19-20020a056870ef1300b00203b690eaf1mr938757oab.81.1704390973807;
        Thu, 04 Jan 2024 09:56:13 -0800 (PST)
Received: from [172.16.49.130] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id de7-20020a05687075c700b00203af6ff47esm6574332oab.42.2024.01.04.09.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 09:56:13 -0800 (PST)
Message-ID: <4f793406-2033-429f-a575-105a5dee2b10@gmail.com>
Date: Thu, 4 Jan 2024 11:56:12 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] station: handle netconfig after roaming for FW roams
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240103184638.533221-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240103184638.533221-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/3/24 12:46, James Prestwood wrote:
> This was not taken into account for FW roams and would result in the
> station state being set to connected regardless of netconfig's result.
> ---
>   src/station.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis

