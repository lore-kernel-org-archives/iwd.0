Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6691C288
	for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 14:30:14 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6bf2427b947so3246841a34.3
        for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 07:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695652213; x=1696257013; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJtaORZGsKXSn1xu70yRki9qoTVjejomgDJXCUwwBUc=;
        b=PP5P1wYKYnC5kdStH63VLemawem9xAXVLc51yuK8hz8Ge9Agrtk2n/0dpmstJNIXj/
         wxhef90jJpRObFaVPCUN96P/lVWbt3Q9ilkk1KKHihRFwuGSbOTfYjj4qRLMBbCGa6Da
         yCzvAmz/d+UFvsfsbJ5mOyNfnthdea/sT/qri6h8JPjR40DoUn3dnrqz8/fM3nPruci1
         RdDCgpHhH90l2nZb3xER3rzkXB1fUNUBhD/xh568qXoCWUn1a2WilZPZP9ahBM5Jl1PA
         T0aM3qZxOhZmZ27GyzFl9SZR2DV6hy/vG6LFNu0bBxfoO3svozmfY/FbE1PA/KdKomOa
         GeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695652213; x=1696257013;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJtaORZGsKXSn1xu70yRki9qoTVjejomgDJXCUwwBUc=;
        b=oTeNSCDTQU3hvmZYS53B/rzQmcuDDxSRyLyYEtwowcjxRh9ORUW6LeGq7AovKjQB5F
         ryKkycW060iy3Ktm9okDCIcSeEiB/LKK59+PFAeutwtGqf7uEO+mUTpNkFo6q5/CE+qF
         4mMEZUHJUY8L0AQDkz5VAKgNSGI+YX1vE598g2CBFmAiSD1QBnChHVgkJsCAYQmxQUQL
         vfRVVlMb8xOzAvyWrl0BT1jDVIw4XcnqLwPk6b59L4/P94NlHCa5PyTXONez0Knc0Cjh
         UDJYiZXghQ1JPXMjBMjW9ImGQW27MBoy82MF4+FR7H91IEBzHt0iT8L2Uecfhb7u5BJg
         HT0A==
X-Gm-Message-State: AOJu0YyroZVA6NT0TP49SEi4k1XCXoYZVu4c1h1ife3LS1bHp1fcG2xY
	BTgJYpiuIMgy0h4GVZXxyD0=
X-Google-Smtp-Source: AGHT+IEBUlelWPxpcI797qx1z3Cz8rc3dfzVIopjceKh28MS8CZrWwhU3MxUBLYZzX/Avas346qGkg==
X-Received: by 2002:a9d:62c9:0:b0:6bc:bd1a:26d with SMTP id z9-20020a9d62c9000000b006bcbd1a026dmr6718509otk.15.1695652213243;
        Mon, 25 Sep 2023 07:30:13 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id e1-20020a9d7301000000b006b83a36c08bsm1738157otk.53.2023.09.25.07.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 07:30:12 -0700 (PDT)
Message-ID: <00fc724d-a222-99e4-7301-4d668d5df399@gmail.com>
Date: Mon, 25 Sep 2023 09:30:11 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] test: log correct function name
Content-Language: en-US
To: Sertonix <sertonix@posteo.net>, iwd@lists.linux.dev
References: <CVMUXBOJCCQ3.3DY5I2CD7ES6U@sert-surfa-alpine>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CVMUXBOJCCQ3.3DY5I2CD7ES6U@sert-surfa-alpine>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/19/23 06:51, Sertonix wrote:
> Matched the printed function name with the actuall function name.
> 
> The simple-agent test prints the function name to allow easier debugging.
> 
> One name was not set currectly (most likely through copy pasting).
> 
> ---
>   test/simple-agent | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Looks fine to me, but I can't apply without a proper full name in the 'Author' tag.

Regards,
-Denis
