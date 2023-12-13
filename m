Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6845A2D604
	for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PE0BiyfS"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5910b21896eso2065249eaf.0
        for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 08:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702484096; x=1703088896; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ADhdmUcfuMtlEaspoSK23BfB3z+DjYGkVm8O43TPwLs=;
        b=PE0BiyfSHul2rgFsAn+i6pBumkoEjUxZWhsAQwE0JExlAuNfjj/tjjX8P7QvWnoL0H
         2qN3Dhz/hScWmdI4asb9q/g2Gkd18fUOHA9wYEa7A51yf/+HNc8uMGjVFF58eT17JlTo
         vbSykxjkguHC3ysaL2XHrkBOfc+3zdE7CSZ1nJzsu5HkevUVSUnHbqhZWexQmptc4Qbr
         /X5JmPct5RMoNefb7oqVaViyfIYIZwvO5Ls4K+7ftTax+YW51nYFHhcteBnWZgKWuLol
         Mf3UVSgI648496VBotdQ3+Y2cjT/oOJgQ+WG4RRLRVCozZpLc4jdRXCJdnYKHdDBrjsF
         stGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484096; x=1703088896;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADhdmUcfuMtlEaspoSK23BfB3z+DjYGkVm8O43TPwLs=;
        b=Cm/7SgpcgS4YMLTzWU3FAfmPO+7PujqqTMLqFlPcGp5zfH3ad2CqXViSb7ePLvSi9x
         sfXCxgB4TjvVUQQUTDJ29Qkqz1p/qGq150VsH59b/ccDpGS91glrE879kENxJzfwWnBv
         YtEb2vvAEJs/gMJ9KP7qfgmy5YrLJOWYaf8DWOPoZmKSz2y+4DIjumV7ZvynYBAfV/zJ
         5ukfiMhDtixhnW4aAw3rd4c1h6jtUNyAu+yzJwwqWgxRK7DeqriohAubTKhmNFdDu3ly
         1GTYKUp+FNBxdtfqMpQaXP32lYamFb5TfPrQ5hnxSGToE//7FBKABttag6xWlZzhbBJX
         gpgQ==
X-Gm-Message-State: AOJu0YzYV+myVw4ZVxF5X3QDB5Akaj2LjuCF3lBSj5cdnyAQlb+O58ff
	QXmDSZ7V9w3lL4JjRBY2OsE=
X-Google-Smtp-Source: AGHT+IFAGtFNSUAJFsY5tR20xohAtAIktsAJiwrL9cF9gpdWJRxy5hxpD/r4O2hoENJOyC4FfvZMwg==
X-Received: by 2002:a05:6820:1ac9:b0:590:87c5:2b0c with SMTP id bu9-20020a0568201ac900b0059087c52b0cmr5757575oob.7.1702484096525;
        Wed, 13 Dec 2023 08:14:56 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r124-20020a4a4e82000000b0058cbbf9b4e4sm3099633ooa.48.2023.12.13.08.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 08:14:56 -0800 (PST)
Message-ID: <706a7157-9d37-472c-b610-7f0a2c3a69f7@gmail.com>
Date: Wed, 13 Dec 2023 10:14:55 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/13] auto-t: add explicit stop() to IWD class
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231206201802.2139649-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231206201802.2139649-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/6/23 14:17, James Prestwood wrote:
> If tests end in an unknown state it is sometimes required that IWD
> be stopped manually in order for future tests to run. Add a stop()
> method so test tearDown() methods can explicitly stop IWD.
> ---
>   autotests/util/iwd.py | 4 ++++
>   1 file changed, 4 insertions(+)
> 

All applied, thanks.

Regards,
-Denis

