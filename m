Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E25F1FA
	for <iwd@lists.linux.dev>; Tue,  5 Dec 2023 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee4E+ehA"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-77bcbc14899so392757185a.1
        for <iwd@lists.linux.dev>; Tue, 05 Dec 2023 07:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701791285; x=1702396085; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eBoPGCc4fQWs83LbNhtf8dWcgIG/KT68gZN15DaBzvw=;
        b=Ee4E+ehAiJV5jXk0FFnRya9X6Q0vgdgmzmBXdMKmeAyKzfpy1/6Da98k0LNQdfCNS4
         j4IWI6gah9YSzbTTDtIRMULTAnb4Is79U/uAqpte5gyGAcEEctY0Q+ndb+r9GbJpyc15
         uOMMP0nuFudnqoj7OqaOqUp7WfaRhsbilN8Ng2Qo6x0QLWturr1WvE6LfQc8/eVIAkiQ
         21CjEKd2yRDTfjz8aE0nNNaAzCxHMw8QBVdKmDIU8nrV/OMJdCzSIggVCSeVyIvM8I9S
         u+/xKVHJU38AxwAn7Bh+aSV3DCwz9GxkZhrs0bWK54pgSMEqMgNMBJOTTtqi8Zn0s4te
         eB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701791285; x=1702396085;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBoPGCc4fQWs83LbNhtf8dWcgIG/KT68gZN15DaBzvw=;
        b=TOFm0jrcisk/V+QO8KsLRLtigtqHKAmEGUwWHlyknr23v72IKXZb821kAq9+F96JV9
         SulloMhMpuTFBimkj8yE3/B10wBN9pzyx8piQdhRsq+6m54oHGfq8lAYLJaJpLngjtmD
         93/eqerF0/vZNlVS6xRE3u9KKG6lpmkzzifXAfQeJJk+ojf07V78m2IaGgkOklXox72F
         l/oFtAJz6C4Bb9lDh/DtT08pv1zxjKs6q/YRg0kzCgPb9G0T4O4jjIgms1quP/1RyX2I
         d7rdDdOPrY8JgbfCC9uK60UKMwuTi/6smB3SobAYZi3GyTxMNTDCMD+BFrjbu0x85qKi
         zfzw==
X-Gm-Message-State: AOJu0YwsotHuj6LDshpffj7LZU7auSJghAYsMpY/R4hPlTZ6GwSa9V1d
	PJOCqb2S03k8VIDtR0YMSS0W4JNCqzY=
X-Google-Smtp-Source: AGHT+IEbnIBmalPItb2wdK0nwAJSBF3Rkx38hHZTvfLME38MvVYMaJfEk9pfcctANXTb+hWOCpHpuQ==
X-Received: by 2002:a05:620a:1996:b0:77f:1773:1163 with SMTP id bm22-20020a05620a199600b0077f17731163mr1774565qkb.81.1701791285214;
        Tue, 05 Dec 2023 07:48:05 -0800 (PST)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a134700b0077eff6eece8sm3135764qkl.62.2023.12.05.07.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 07:48:05 -0800 (PST)
Message-ID: <a61d267d-774a-430e-adc6-5fb1f5075860@gmail.com>
Date: Tue, 5 Dec 2023 07:48:03 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SAE password identifiers?
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
To: Ronan Pigott <ronan@rjp.ie>, iwd@lists.linux.dev
References: <e3bb952a9c0550a945f002b1dc5c596e370d600d@rjp.ie>
 <38a83f9c-6ac6-4862-99b1-128d811a63e5@gmail.com>
In-Reply-To: <38a83f9c-6ac6-4862-99b1-128d811a63e5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ronan,

On 12/4/23 06:40, James Prestwood wrote:
> Hi Ronan,
>
> On 12/4/23 01:56, Ronan Pigott wrote:
>> Hi,
>>
>> I was looking at WPA3 recently which includes a specification of the 
>> "WIFI:" URI
>> scheme. I was interseted in creating iwd .network configurations from 
>> these URI
>> but afaict iwd is missing support for SAE password identifiers, which 
>> may appear
>> in the URI. Is iwd capable of connecting to these networks? If so, 
>> how can it be
>> specified in the config?
>
> No currently there is no support for password identifiers in IWD's SAE 
> implementation. It appears to be somewhat simple to add, an extra IE 
> in the SAE exchange and adding the identifier to the PWE hashing.

I went ahead and added password identifier support (patches on the 
list). I've tested this with hostapd directly but if you have an actual 
production device that supports password identifiers it would be nice to 
validate this actually works.

Thanks,

James

>
>>
>> Thanks,
>> Ronan
>>
