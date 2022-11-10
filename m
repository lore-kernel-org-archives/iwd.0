Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD8D2FB2
	for <iwd@lists.linux.dev>; Thu, 10 Nov 2022 15:27:08 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-13bef14ea06so2518699fac.3
        for <iwd@lists.linux.dev>; Thu, 10 Nov 2022 07:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ZzQ4DpBLmorqZas5uxCD4kp8lMGgO8aQl42V16YdcM=;
        b=PIBY6qY/RTCtXUCQOj5HSBqmIXqoj4L99wCATuu4THwTeHisRWM53ucAyhKMHyh0U6
         hu+OwEhZJ6A83cH+dlKaMBPEOgksBLVNcV3vYfNUaIaXyAjHB3GAEa/eblsluxMikM9I
         wnxlN5YFNcxT3G/ElonziF00XcY5yWdAxtokt55qqlVlhuDfCMr+1XDkicqrZsxdjCY5
         z/A/E3IceT2YLZVdKPkd3TdDc0/OistUtFjZwZETJFxPUP10xdOKzj+IGZsOF8tnBjON
         oluAk1LdQvjQb7ImOnauVydE4bjZzsHW5F+T3FkL5xBWkk3bSDDEnk7Z3+MJXVI/JMrK
         T2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZzQ4DpBLmorqZas5uxCD4kp8lMGgO8aQl42V16YdcM=;
        b=qTLW7zCqdjzlpOhF52Mgle6AKUTWN6ccEh1Y7Z8/j/2kyFe6M/4Z0bYiSuixppRjuu
         QOp7FKUIioej1gbcPaFGDnC2iSHgIHRmt4KlNqd/u4Sx1FbtkTwbdT2At+1SwuMhIblV
         k6dhdGUHY+6C+pZfTngGDxOx1QBr0x/q107iXoM88JJfUM4fg5GKco25m65IMWbQANEm
         eo1UliSGpsre/HQTMiLqrhrDbQNhsjS4MfO3FLzjmjfCX6/n/8qAitxI66Bx0sSfUd2c
         rbOcjKYpOh6MGSXPdQZEibrsp5CO6sM4U2o6YYgZec8KS3udMRLvlt8HLNb80d8tsNLX
         MVKw==
X-Gm-Message-State: ACrzQf1tN71EHy9IBMTFFLvsRbP0xKyhZmqws+YDDvFNAJ9UHFSKZzWu
	pW8J5C9MKvfw5f8Gpb5G2U0=
X-Google-Smtp-Source: AMsMyM5zefNTBNT92xWnVx75pqxkghWub6N1FVUIs0mOsWH0hZcAudTYSMjrAdvu7ROy8BGARi9fVg==
X-Received: by 2002:a05:6870:2b02:b0:13c:97e9:5d40 with SMTP id ld2-20020a0568702b0200b0013c97e95d40mr1597293oab.42.1668094027141;
        Thu, 10 Nov 2022 07:27:07 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id a8-20020a056870e0c800b00130d060ce80sm7663173oab.31.2022.11.10.07.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 07:27:06 -0800 (PST)
Message-ID: <411a7e6f-9439-5998-0e57-9ca401c269ba@gmail.com>
Date: Thu, 10 Nov 2022 09:27:05 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Sometimes RxBitrate of 1000 Kbit/s
Content-Language: en-US
To: =?UTF-8?Q?Patrick_H=c3=a4cker?= <pat_h@web.de>, iwd@lists.linux.dev
References: <5893463.lOV4Wx5bFT@mmm>
 <4d50da71-40e3-f888-be79-b52fa8208e88@gmail.com> <2259038.ElGaqSPkdT@mmm>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <2259038.ElGaqSPkdT@mmm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick,

>> Some network managers (like NM) will explicitly IFDOWN wireless interfaces
>> on suspend and bring them up on resume.  This isn't cost free and we'd
>> rather not do this.
> Would it make sense to do this optionally if a new config option were
> explicitly set? Or do you think this is the wrong layer or wrong approach to
> do so?

It isn't really clear, to be honest.  I would expect this to be handled by the 
driver itself not iwd.  But maybe if the drivers / firmware are broken then this 
is something we might have to (optionally?) enable.

I would be curious to know whether manually triggering ifdown/ifup on 
suspend/resume fixes your particular problem.

Regards,
-Denis
