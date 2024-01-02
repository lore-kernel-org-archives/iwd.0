Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB51548E
	for <iwd@lists.linux.dev>; Tue,  2 Jan 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggG9030X"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-204ec50010eso2638046fac.3
        for <iwd@lists.linux.dev>; Tue, 02 Jan 2024 09:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704214971; x=1704819771; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TuImeVMmSB8WihCPA1V2f9o9WqoaBX9Vk+c4IELpuwQ=;
        b=ggG9030XLqbhD/9T1vndH8P4NGVYl/hj0htQop193n4FdNXaZPjY50zf9/7ZcuQAhL
         6U5wO6la8DY8tAzDfXj3KcuPf+T6uMtNrubyLm5dFSP7ry4Z+Kto4mTz+Gm++hcayXq1
         rGL3mavSeIDkmpxic9ysuCj9Fqth1ENc5BO8+nz6VNdLirtga/9NOSIqtQN2LHpw6jKA
         tSB1nCsDjVGcLuD0DuffhGSF+RLEjZLdgu8FqEUeeSozhzktzk5Jna79F8VpOq1vWXU2
         NZ0cjhMnEAPzCR6BIuq7oRdmDrppFgFN6G4aw5vV/o6VEO4rOlpy4OhWCXXewpfh3ZJn
         /e1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704214971; x=1704819771;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TuImeVMmSB8WihCPA1V2f9o9WqoaBX9Vk+c4IELpuwQ=;
        b=FbNMIanMK0df0fdDcJ1HBEA7RXX3nktVbpVnlYJC2N0mOd1AlqjzDpRulryWp1EXvm
         V5+To9/lTJfVDH3Mjo2MdidYBk1E+5Ije2BPp7OK7EIe44KCi6d9nO6XnpIXsQSnSaAw
         /efXyZYAVJ8TwaQq6Fv+dT71jaP4IeDn+EjSjcUWOL2O6gaAfQymBODm4nCrdTcve+2m
         HMGoyC/UmTfcTabtvxFHjYeDy7iCzkuNsV7S94JrAOHJK7I8VWurCqiy8lUEo3JNjjKl
         u4VI25+ZKojqrGftc34Z5/z+aXmcy5A2PlyV3B2xixOOKe9zaEZ6L7rhXjp1fPGaUYOn
         TJXA==
X-Gm-Message-State: AOJu0Ywo7ElotT9RKJoKa1oFfXQLw/n/qSa1dHajPDbx8Fuik4R+TGyg
	NkatG0sLYL2zgA7ejrC5BD2XAy/oR1Y=
X-Google-Smtp-Source: AGHT+IH83XsAWMs5zEEhaJK8kd92KVtLWk3eE7V1/8UfmLWXkyAYUqaprbvXzbHofcwIZpLlZ+RXJg==
X-Received: by 2002:a05:6870:f114:b0:203:acfe:20e5 with SMTP id k20-20020a056870f11400b00203acfe20e5mr17282616oac.4.1704214971502;
        Tue, 02 Jan 2024 09:02:51 -0800 (PST)
Received: from [172.16.49.130] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id pp19-20020a0568709d1300b0020472215893sm4363632oab.31.2024.01.02.09.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 09:02:51 -0800 (PST)
Message-ID: <d2a47435-2b51-489b-8d58-721591b5a73a@gmail.com>
Date: Tue, 2 Jan 2024 11:02:50 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: indicate if the MPDU was invalid
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240102130355.17660-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240102130355.17660-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/2/24 07:03, James Prestwood wrote:
> If the frame was not parsed as an MPDU indicate this in iwmon. This
> also adds handling to print probe requests.
> ---
>   monitor/nlmon.c | 43 ++++++++++++++++++++++++++++++++++---------
>   1 file changed, 34 insertions(+), 9 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

