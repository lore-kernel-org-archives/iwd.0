Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB45C315A9
	for <iwd@lists.linux.dev>; Sat, 25 Nov 2023 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aujYZU8u"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b8672b9482so11096b6e.1
        for <iwd@lists.linux.dev>; Sat, 25 Nov 2023 15:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700955015; x=1701559815; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J802V6UJrbFS6TAy1s/6uFLYtkCCBIt+zmvFhvmr4e4=;
        b=aujYZU8uKbJ0wpDC2794NbtaYY9hqOMJNW+vqaBPkxfORNZZYRPC3mRt4QnCe/4iYF
         6wnnMZVQc/IDw/oGfWav1KhfXbDY5rI9sEvP7a7g2YQDrgfe1e4Y66HfXAuqi+Ov2DMZ
         5+/beV1W5s2WxNVtpOaPQSD/5QBgu+3+Lv38kUeFTV4kRPp1FMNX7Iqn4uresSeOl3rb
         LaZujAXYCG9jRz+VjJQYj1cHrtHF1CXVilj9YWj4I1FUqGjl5NAVzH5Ka7qPBGRNZA45
         nL5wcMiTFEN9Vn2XZDOZj3M9gqZsLkx4qRty3/PHtH5vcz4XvkwbUhL6B/WKIfs062WX
         Lm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700955015; x=1701559815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J802V6UJrbFS6TAy1s/6uFLYtkCCBIt+zmvFhvmr4e4=;
        b=Z7Pc4zWjfA5x1mZC59Ugx6ofIutNkDdXEP7KFyfs+wWYjDLiP1QwFTUH1ak03xlksI
         QWh1Oa9X2mvVx4r9IYGUgh5ZCJSQCMawH5+9o4EuTH/G8IcakobYiQ4yKTBkyZV5CrlS
         TWLjiToCvMAOtC2G5Y9rMLi7Q1QxqNNa6NiGyvg8ew4dGdL+RKHzs6v8dQRreYdQ4kmk
         C6DcHD/ftnUQV384OO9pNpGiCClGJ3ThiDY+7dOpQyuH/NAnAHDlhbH8nCeZj269zMx7
         zN0FgtxYhNwSs/j+7LlUsANOGIgJVJERmmXgP7X2n89A2jYN6nN8vzZ518R24s7TkYxo
         kteQ==
X-Gm-Message-State: AOJu0Yzu706ZN/ml5RPmj1xV3Eg88a2JwyjP04HHUvItGPVGOqKeh/jb
	eK+tvdxA49Y6NCVC9NTXBmlNFqVZfik=
X-Google-Smtp-Source: AGHT+IFu30s9pRHgpBU7lo2krv0Z6pXb1wuol29s7y/sdSjL4ZDBSWD8ldbwOWt5H/3zpkBWCzehuQ==
X-Received: by 2002:a05:6808:ec9:b0:3b5:9968:126d with SMTP id q9-20020a0568080ec900b003b59968126dmr8806450oiv.43.1700955014769;
        Sat, 25 Nov 2023 15:30:14 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bf4-20020a056808190400b003af56ef1510sm1007121oib.20.2023.11.25.15.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 15:30:14 -0800 (PST)
Message-ID: <f49fc888-6b64-47cf-873c-dd24bfbef139@gmail.com>
Date: Sat, 25 Nov 2023 17:30:13 -0600
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
To: Rhys Perry <rhysperry111@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hy?=
 =?UTF-8?Q?gensen?= <toke@toke.dk>
Cc: iwd@lists.linux.dev
References: <87fs0ve52l.fsf@toke.dk>
 <0d1aaf1b-09b3-48c9-82ed-fa3a46cc56b2@gmail.com> <87plzzhz4g.fsf@toke.dk>
 <c3854a08-c529-46e2-81ed-29cd4046de4f@gmail.com> <87jzq7hweq.fsf@toke.dk>
 <CAGTBY+t8-4wMv9VEBPsno3e94dfZqjDB53bHyNT0mzrj8Byh5g@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAGTBY+t8-4wMv9VEBPsno3e94dfZqjDB53bHyNT0mzrj8Byh5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rhys,

> 
> Just gonna tack on the end here that I was also experiencing this
> issue - posted about it in the IRC but there was no response. Thanks
> for the fix :)

Please post any bug reports to the mailing list in the future, it has much more 
visibility than IRC nowadays.

Regards,
-Denis
