Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336CF273CA
	for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaUhV0bu"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7789577b53fso274848085a.3
        for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 05:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698150781; x=1698755581; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6Qe+ey4ZmpsSUeZVmZ0VQQuTniuqNzcRAPwWX/hLSk=;
        b=LaUhV0buFsjUkBc2koeXtApihI7ISQVjRm7/ZFZvTiOR3DcMZZq1jF9NYja3zqOOM0
         MEAjCN8upY1RJnwTgtpwzQBLlsc9AtYbs0yyVabcFgJ6vKTqBNvC2QXvEPwFLaZO5enB
         eE8O5J+hU54hzSkRsRqidavPAmWoQyJs8Z8G7pqF50Bi+MUXPL4qdwyasAwPR6nv+KsT
         YFMS/knOG/PpPbu/y/h2j34HCvk9eVVMaEmiRiTskPxx3+DnIql2njX6Y5Xf6VLqEpbG
         NGt0w4udYVTg2XJtD/bvc7/jlTXlHR2/Avkoy8Ji6qBKZHQYJbS7ZVFsjZtbnwSJ9TwS
         kaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698150781; x=1698755581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6Qe+ey4ZmpsSUeZVmZ0VQQuTniuqNzcRAPwWX/hLSk=;
        b=iH1pUIfcYlPBQvRkRIvKSib1t6bnpE/FkV2zrROQDinnNw2N0mbvHoEwz7G0M/uXJq
         TWNGQNMFhT/EF01LRAZt1MgHo5MA2y3Mumfg+xOX55FlaZhf+lvAK4Mwo+FqAFym3ngc
         /U980KUu/Sa4fD/R5tXunBe+LmZFQN4XaN6ZY6mjMwz0lCO7l09cjsjbbowTO/WZPFad
         09U4V8M1MXy2qHgCfpgYkAgeN1O7EuwBAXUZP40hwdpJPuAtKSx1iR49BRde1M3uFaAk
         V3KP+ayL297cgOv7B3dPb3GxeRPoki4RklwLm8BtDV2IBeKcg+Fp/fJqb1s8+O4k+f1V
         nvRA==
X-Gm-Message-State: AOJu0YxY4Wt+U14niKejKwBY2tW1nRgqgA/Pw3YqoJ7XaIzOJK8NiT2A
	/IHDP/NLg2gibzn19zzm7e4=
X-Google-Smtp-Source: AGHT+IFf7VOB7hrLvDIJh7xKoiBjZOr1nVslm3cyVyWl3t/XweRBWIaKWRCEYVp9mfpHymqsFcl3TA==
X-Received: by 2002:a05:620a:3193:b0:778:b3fa:e0cf with SMTP id bi19-20020a05620a319300b00778b3fae0cfmr12304525qkb.40.1698150781329;
        Tue, 24 Oct 2023 05:33:01 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id br11-20020a05620a460b00b0077412ca0ae1sm3400542qkb.65.2023.10.24.05.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 05:33:00 -0700 (PDT)
Message-ID: <9e12bf94-aa83-4fe6-b045-8dab45b264ae@gmail.com>
Date: Tue, 24 Oct 2023 05:32:58 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is the data rate estimation for 5GHz channels overly pessimistic?
Content-Language: en-US
To: Denis Kenzior <denkenz@gmail.com>,
 Simonas Kazlauskas <iwd.lists.linux.dev@kazlauskas.me>
Cc: iwd@lists.linux.dev
References: <xxpypqwyk3gjrwjmpuvxqdlipkrb3fbw7augfey5ovr3lgbgul@2tbf6xw2uo3z>
 <5780e1b2-8956-46bb-8116-b513cc564cea@gmail.com>
 <5ff58310-c5ee-4694-821a-0c802cdedb89@gmail.com>
 <bwuu4ra65fpfpenytgu5a6ftjpvyury4omx7ucy65cshorqskl@5ikhebki4wnk>
 <05aedfe6-82ad-4e41-a9fa-e9f8a5619947@gmail.com>
 <tkizdohkwpz4nfgjczdzltr7qhvjtcyyk6x3543dht2gmm7ssc@q7m4rq3r3sqx>
 <f7ced477-6fa4-4efd-bf54-817b100041ef@gmail.com>
 <ccb68e07-e4a0-4e50-b7e2-2a2044d38487@gmail.com>
 <30b6dad4-64b2-41ca-8712-053cb1396eaf@gmail.com>
 <ncmtsi42vkdimzxsuktgfblp66agskivhuntdjlooyp7gglhgo@kwuxknllo527>
 <sebayhpora5e5ispmp5nnjesihoewc74ohygd3orxp7k22ky4c@tt225sdpjrxm>
 <29094eca-dcf8-4234-8afc-13d37db8450c@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <29094eca-dcf8-4234-8afc-13d37db8450c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis/Simonas,

> 
> Now the question is, how do we make sure iwd is estimating the HE rate 
> if available?  Also, how do we tweak the estimation logic with 
> sensitivity numbers (obtained from a spec sheet, or through 
> experimentation) for specific hardware being used.

Trying to catalog different hardware performance and act on it for 
ranking is an impossible task :)

The only simple solution I can think of would be to add a user-option 
for some threshold RSSI in the rate calculation. If set and the RSSI is 
below the lowest of ht_vht_he_base_rssi just use the last index (-82) 
(and maybe force a 20MHz channel width?). This would at least let the 
rate logic return _something_, albeit maybe not accurate. But again, 
those RSSI thresholds were sorta made up anyways :)

So you could set:
[Rank].LowSignalRateThreshold=-90

Any RSSI between -82 and -90 would use -82 for the rank calculation. No 
idea how this would play out in practice, but its at least simple and 
not tied to any given hardware.

Thanks,
James

> 
> Regards,
> -Denis
