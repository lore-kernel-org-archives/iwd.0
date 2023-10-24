Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B4266AB
	for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvxFU5Th"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-77896da2118so299584785a.1
        for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698162059; x=1698766859; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v35ZIPmc8MkEl34tr1m1iZzYr1f58fXQnIx+Nkq6/A8=;
        b=UvxFU5Thz3Z7MebFV6MsQEUHvOcL9sCkBzh/RH80uBn4+DbHcVhTO1uk2dfxpLeUw3
         WL/qXTPD0raJbol1cpBKaQaeyAixbXdju9nW0rRawZBwb3Hsbd8mFgvIHLxqu1KimDQw
         jlBrC+2Fi8fGUgmjgnggSYNlbHuxDx9BRGW75kGMx2RvUDWUfd1vVBjs2agNMpe6qZZx
         Kp91UzHF9yYzhWsv1/r8UuyYX3JvAdybYblrgAP//ezjraeyd5PyxpXE4/Ij7xH1Wrjl
         gFJrGKus/Rqg8iIP6T1PHd/Do7Jvpnx9ZkzHfMJ/21pWWUZ2G//d/Oy+ml/RbdS3jRCh
         U3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698162059; x=1698766859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v35ZIPmc8MkEl34tr1m1iZzYr1f58fXQnIx+Nkq6/A8=;
        b=DT6Yp3cXINfuDX34qA0mkqtZRXAM9cob1hOiZY/IhRdiiwudqgvuMLxw6vZHNUM+CD
         t7FyXQV0OrPJgkSIu1qxo1tG1NQgVwQi7p9hEgQvbBTd7Jr38kkGzAZuefOM2g3tPWug
         v+QGLGmiEDIR7ZSr8dvktqWw7OYvNozhCVbk+scspWfwW5RtyH/uGhACkUmaP9y1/knN
         0JK1wqxjbpYI5pBfBgyN8wa0mYRgIdGma4sFU1XK6t5Wwf6ee4X2CyXs3lpRmI6GBPD5
         CrbkAbW/ed4+qIZLi+blBwZmDeGaQiih0ym3PK7dwGVvz25aB1iGZqdRhD/LjPEx1Ona
         gSKQ==
X-Gm-Message-State: AOJu0YwGxVY5uMJ3Uw0hm78vRiuYTUyV+yO76POVmU85k4d8gC/TsbgI
	Nnxo4WN+QE2x5DOthujNUJs=
X-Google-Smtp-Source: AGHT+IG1KZeOmx3IHAPK7fVfUGNZNPt3BkN+hbbTtduY5p3mJv4vnO9BgykiPH6tw73bczPrbZ9Zgg==
X-Received: by 2002:a0c:b254:0:b0:66d:138f:95df with SMTP id k20-20020a0cb254000000b0066d138f95dfmr12166232qve.56.1698162058854;
        Tue, 24 Oct 2023 08:40:58 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id s4-20020ad45004000000b0063f88855ef2sm3638557qvo.101.2023.10.24.08.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 08:40:58 -0700 (PDT)
Message-ID: <71f5cd1f-ea9d-4e47-bc4b-eeb0a1ceb310@gmail.com>
Date: Tue, 24 Oct 2023 08:40:56 -0700
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
 <9e12bf94-aa83-4fe6-b045-8dab45b264ae@gmail.com>
 <3d2c3d76-e08c-4d71-8a72-7193dd51cbfc@gmail.com>
 <8a9039e3-1db3-459f-874b-e53d8dcdc16d@gmail.com>
 <1740def7-87b2-4d14-a6b1-c4522b9dcbf1@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <1740def7-87b2-4d14-a6b1-c4522b9dcbf1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/24/23 8:32 AM, Denis Kenzior wrote:
> Hi James,
> 
>>>
>>> They are not made up, they're direct from 802.11.  But again, they're 
>>> the _minimum_ specified sensitivity.  Hardware typically does better.
>>
>> The rates/MCS table (ht_vht_rates) is from 802.11, but the mapping 
>> from RSSI to MCS index's (ht_vht_he_base_rssi) is not. The spec just 
>> has a formula for calculating the rate using a given MCS/channel 
>> width. IWD just chooses what it thinks the MCS will be for a given RSSI.
> 
> Sheesh!  Everything is directly from 802.11.
> 
> 80211-2020.pdf, page 2835, Table 17-18.
> 80211ax-2021.pdf, page 642, Table 27-51

Apparently wherever I got them from, got them from the spec. IIRC I 
couldn't find such tables when I was doing this, and found something 
online. Hence why I left this comment:

  * Note: The values here are not based on anything from 802.11 but data
  *       found elsewhere online (presumably from testing, we hope). The two
  *       indexes for HE (MCS 11/12) are not based on any data, but just
  *       increased by 3dB compared to the previous value. We consider 
this good
  *       enough for its purpose to estimate the date rate for network/BSS
  *       preference.

I suppose this can be removed now since they did in fact come from the spec.

> 
>>
>> I don't remember exactly where I got those values from but this seems 
>> to match:
>>
> 
> The spec?
> 
> Regards,
> -Denis
