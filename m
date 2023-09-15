Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA09433E8
	for <iwd@lists.linux.dev>; Fri, 15 Sep 2023 14:35:09 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-576918d0a42so1196109eaf.3
        for <iwd@lists.linux.dev>; Fri, 15 Sep 2023 07:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694788509; x=1695393309; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fx0ALe0dNb5PJpPqGKAyvY6EskK8hm7GLnf01Ijon1Y=;
        b=GwUwjETfPIaR+1XOasRQ/e8HdVkCGiUiisTcYNsObo4MCKE1tfrvchAJJYDsiv2s0E
         w65Tp82AxGu0txlJohfTwLz8niqPMpXnR69Crl0T+FVSJKx64S+KEmW3E6wv4UXhrst0
         QW/+qjddRyOpLEHqb8eALTBG9/1irqAm+EVgcY/iJh1MebY4Vips+4b1Chm/cnY7WtTh
         kh7SJXB2UsxV+6xHxKwg9nj10vLKHa7b59+cfLGe61WbMAfKc2e1SFQoxyLeeZh1OOel
         59H5gSCko43c3tUqU0IA0iOIEPMsojaAiD9yBupXtcmJJrHaOs1cBJmfNH3PZ+A4I3hm
         qysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694788509; x=1695393309;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fx0ALe0dNb5PJpPqGKAyvY6EskK8hm7GLnf01Ijon1Y=;
        b=nQ3A4fJ7CwG49RoKow6FWtJW5NEO6T7XtAyvbO76quTHB64/bVGFXkaSogpTK3XWmY
         QYQjlfJErI+NS7VgqF7XaWe9qf2T2WX+enkuF/O86ez1Y4a88iUcYR2GRRlIFRlaweQx
         sYM+g5a44dy2xTgiYxHnwFDLRMiHEQNsTAmU6WW4dUscLkyiLGMsn2gASVC3UgoL+0Zz
         xZAL9FdIznyWURZZj60RLnREbTALtpWgGN+oCazWt6jrJBDlbCM125Foo195vEeDdKfT
         StLR0FPREROzuVc8H3DJGm344df4r5c/GFulbRtUfOjQO6pvVMAfXQv+0le1mv+ICn18
         WHJw==
X-Gm-Message-State: AOJu0YwUGLfhhiGO0NcjmC2y38VFBzEq/vpHa6WUBjDlkUjrR44ZkLd4
	9Ip9yISQpmif/NXza8t35aOlFz+he08=
X-Google-Smtp-Source: AGHT+IFVKMuWBQNh1X5oAT6M9DUJ9I6ib6e43pQKqr6AG4MdaLVZHQ0HOL/kokNXN7uqmfdAVm7zPQ==
X-Received: by 2002:a4a:3116:0:b0:56c:e856:8b2c with SMTP id k22-20020a4a3116000000b0056ce8568b2cmr1892776ooa.9.1694788508986;
        Fri, 15 Sep 2023 07:35:08 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u8-20020a4a9708000000b00573320e1241sm1819067ooi.14.2023.09.15.07.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 07:35:08 -0700 (PDT)
Message-ID: <449345bf-a1e2-b435-f855-7048ab0770e3@gmail.com>
Date: Fri, 15 Sep 2023 09:35:07 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Force use of 5GHz band
Content-Language: en-US
To: =?UTF-8?Q?Jonas_Gro=c3=9fe_Sundrup?= <cherti-iwd@letopolis.de>,
 James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <cfdbbdb5774c4db1c8d3ec7d1e09e70e340f075c.camel@grosse-sundrup.com>
 <34795e04-66e4-4359-a6b2-59b3f47eaf64@gmail.com>
 <d0b59d7ddf82006b6280e3b6652614d9ece09f7a.camel@grosse-sundrup.com>
 <6aac9366-36fd-474d-882e-1bcc940fb444@gmail.com>
 <ea23c922129d3c18c4affb0f0e4a737b7e2a03e5.camel@grosse-sundrup.com>
 <e74c1a50-b5bf-48eb-a53e-100d9706e7f5@gmail.com>
 <0d355152339b4e937910fb2440d1d3ace453514a.camel@grosse-sundrup.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <0d355152339b4e937910fb2440d1d3ace453514a.camel@grosse-sundrup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Jonas,

> 
> (Feature Request: also accept "5GHz" as spelling, given that's the
> correct unit spelling? 😅)

Yeah we really should.  Too bad we somehow screwed up the capitalization in this 
case and settings keys are case-sensitive.

Regards,
-Denis
