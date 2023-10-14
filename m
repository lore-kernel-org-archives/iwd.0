Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C1EA0
	for <iwd@lists.linux.dev>; Sat, 14 Oct 2023 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjSeviUM"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-57b74782be6so1679968eaf.2
        for <iwd@lists.linux.dev>; Sat, 14 Oct 2023 10:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697305023; x=1697909823; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6xM+jo/zj0HYByFyQjWIGxd5oCuwXCbI9F+/fKc0Ts=;
        b=fjSeviUMWPH3Pza1hpDcuqWLIwnww9xfB0pw14P+d/a14LJrQYA7LMAIDEKXL8x6En
         jy/T3hm76tWos9l1B2OjzpkcRckc9CLqda0SXXqKt82nhI6ok99gkzWZxnqU7phTeTQ3
         r1yPQYeMuD2mSllUrLV/OndLW+ikMxGiLzkqMilzVnYGt3mN8d1Hxj0mAMfU466kvVNe
         AL7Jjmq1rN+cDF+Iz7C7E+XpbF0hvboPoEv05C3eX7qRDKdNUf4ttR8lmeVQJr7gjabH
         lQ7hnpxsuXx5roIKDWae4iZRH6m3tUsQTKukdV8VlywGH4XtJh1qtwEeGniN+AoXkBEI
         ZgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697305023; x=1697909823;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6xM+jo/zj0HYByFyQjWIGxd5oCuwXCbI9F+/fKc0Ts=;
        b=uGLVgBkQZgruJqnkqucU56l5BVJB6132k/XpYNOZGWemPD8nXfTuc5eGfJWklciVt/
         DVcvmCAndr4ueDZQ/sWmI8IhVLzp3B0AP1rGp2ncvktqi02RIO1TIzlE/a4OrpAc+FoC
         UdaPfT3qupF1BVD4PEDtyJiENCBePRl/KNcWMm6fNHVc5grYmJ0euoTPbuIfnAJB8LIY
         nbXnETPxJDh+D4WX/0GxrgsCqaRIG+z2IwNUGOB4pY5xAM8hwe6wL4wYfLjTBaM0utF7
         cctjcB/G0NC/h9mRxK5XOtuHLvcZPyho6v3Tlxhq71fnWFkoks1vdtBlPZgsdyRqedQp
         UHoA==
X-Gm-Message-State: AOJu0Yw271WbcMZ1wSRDoU8qMMyD3GkMve9AjXjyYAdUnM5uHt/elnXb
	HAuWFk4/p7/+1D6ma8SNdAI=
X-Google-Smtp-Source: AGHT+IHpoFfu/vFxa48TRY7VrWTX/SVRH/RiSZJXgtHT7eWiJS82zm+/vS3/TzOWXwZrNd8XAkC/Iw==
X-Received: by 2002:a4a:9b0b:0:b0:57b:6f3c:2083 with SMTP id a11-20020a4a9b0b000000b0057b6f3c2083mr29285420ook.1.1697305023226;
        Sat, 14 Oct 2023 10:37:03 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id ce5-20020a056820218500b0057bb326cad4sm367678oob.33.2023.10.14.10.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Oct 2023 10:37:02 -0700 (PDT)
Message-ID: <5ff58310-c5ee-4694-821a-0c802cdedb89@gmail.com>
Date: Sat, 14 Oct 2023 12:36:59 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is the data rate estimation for 5GHz channels overly pessimistic?
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>,
 Simonas Kazlauskas <iwd.lists.linux.dev@kazlauskas.me>, iwd@lists.linux.dev
References: <xxpypqwyk3gjrwjmpuvxqdlipkrb3fbw7augfey5ovr3lgbgul@2tbf6xw2uo3z>
 <5780e1b2-8956-46bb-8116-b513cc564cea@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <5780e1b2-8956-46bb-8116-b513cc564cea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>>
>>      RSSI                  -78 dBm
>>      AverageRSSI           -79 dBm
>>      RxMode                802.11ax
>>      RxMCS                 8
>>      TxMode                802.11ax
>>      TxMCS                 4
>>      TxBitrate             206400 Kbit/s
>>      RxBitrate             206500 Kbit/s
> 
> This is probably because IWD doesn't take into account any of the newer 802.11ax 
> IEs when estimating the data rate. So its estimation is based on VHT and not the 
> newest EHT rates.

We should support HE rates just fine.  Just look at the unit tests in 
test-band.c.  Probably need an iwmon log of the AP IEs and local capabilities to 
see why the estimate is lower than what happens in practice.

What hardware is being used here?

Regards,
-Denis
