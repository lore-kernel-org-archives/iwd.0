Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD7118CC10
	for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724932205; cv=none; b=LInP8AxtG1035tFlzMDcbCxbnmJRje+4TLQhsmhqfhhXEidGkinx/5AHRg3i9O4f9oG/xZ+p5PT3S2R4qa2V7+DZW1TYAFOzRRYPPaF+TiyXyq0bVITCI5W49pc8cJ3dyQPoZXRGpOk8AAPFRPpk6aJV4P1iuVAv6sGBz8GXaFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724932205; c=relaxed/simple;
	bh=XxrCr4AwFXZtLaWjWCW9/Bt00MwmWz0RscgGBAM2Nho=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=s2DXdt8F4e+b5NIs1OKFNJ8b95loIp7eGGAUFkH5xYkpknUL8p8dedLwDWKYi4qaOw+UdrJk5Yjp02KgQy8lzgKUwo93om3eKPuqN3rAkucfNj5dsMOEYb+3/O+o9K+uuHV3k8H+8gSOz/WUEiiS/qWvhqeNhO8fYkS4EHd+j3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaWTD+wM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaWTD+wM"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3da94f059so400230a91.2
        for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 04:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724932203; x=1725537003; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LofJfBA8MlHm60oZI2O+UgvTXmn8MVzBval8kMz3NWQ=;
        b=aaWTD+wMfBW8iDcaTmcAS0LY8tWwBIRhvuZZyuy2ws2hkS+v0cYJYZf9tgk7wSjTfr
         JP7amBJobT8OxhlOwmTCVcw4hkoUwNRaRfkS57vaXTbQX6VgJ1ocEN3dDDrjqHlNKWbP
         LUlduEBqjGgr/U24ne5JbxM7PM+Tmy8omBmbrkEjgPjjQAlEDBAEthgYXraMRamnJsti
         oK/UulnvWOdt88LExJ5N2BVtVtPJDJqTSnvjk4NEArVNSTIDWfPz9dCzcDrtbFiWhuxm
         itzI2Ewy/j+a7obdQYRDzA5yDFQtcObG1kUjTGtjVguNHcc6FLFsdpQ1gW77jCxt23Tg
         ixxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724932203; x=1725537003;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LofJfBA8MlHm60oZI2O+UgvTXmn8MVzBval8kMz3NWQ=;
        b=RIMGCfDbPWMwafTcS8TVUvfKPqfPh4g4S9sV5uFgzxFnFm/byjyjDEopCoxNUNGVf9
         xe1Hf1Icl8efCxlr2TS+3RMqnMd5XjeUFp3U/a/pljZgt1L3u8N1r0n3x44E58sbPW+a
         SCj4rlduKTPhi6nClMckHWN3dkGiDZ4WgDYlKxy+AAXxkEh3VkpyVprTKGEOThUPCIYh
         t4DrTmPVEssWsVnGmramkm/LQZGm4NigRqcBfLIJ01DrKZQvliahyv84aMQy1hfWBEKi
         MFeZvndmiVJIcsHvohudtgTjjCjZWyHyWEdxNM/3hs4z3nhW9D4XZBHMfLL2c6Qck84x
         aA0w==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZLz+e3yQUlaM2xTF/WIaA77Y4JZAEd8N2bX1W/Oq62lpSdgGVTk4odzKsZLI0XAU3J0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzfTj8FB/TSzvrJOn5VgkprSDerjCKcvksLG+W8DITO+SMJjfpv
	wajMSxK3iCXAOZKfirUz0hChjgwdHohiOzm1SX5n9za7gZejUbLr1loN7w==
X-Google-Smtp-Source: AGHT+IH4NA3yQkXavlzPUdTldeeex46aypjGtQw0MlYCZ5T87zx+rNDg+BkvsX563xADKekbQVTQ+Q==
X-Received: by 2002:a17:90a:38a1:b0:2d3:bd32:fc89 with SMTP id 98e67ed59e1d1-2d8563a03e7mr2363315a91.29.1724932203366;
        Thu, 29 Aug 2024 04:50:03 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8446fc59esm3873718a91.56.2024.08.29.04.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 04:50:02 -0700 (PDT)
Message-ID: <36c33cc4-9c69-41ea-856d-e47be1dbe486@gmail.com>
Date: Thu, 29 Aug 2024 04:50:02 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IWD CMD_SET_CQM failed: Operation not supported
From: James Prestwood <prestwoj@gmail.com>
To: daniel antoine <univac55@gmail.com>, iwd@lists.linux.dev
References: <CA+iibzCB-6wXch6yFu-4V9dKgz0sJRopsd7wXchccptT5hNB-A@mail.gmail.com>
 <444d59ad-9a07-4d2c-922b-e6c43b7d8cb0@gmail.com>
 <CA+iibzAq50zn7=J+XtH28T=XKbk_Ukoms-K4PYoTrRPEi0J1gg@mail.gmail.com>
 <1c8086ac-1d28-4c02-8c21-c7a37148a9f1@gmail.com>
 <CA+iibzD=UQC5sDwcoOy5_tPm=_58yp-mvV973Sq3dwJrej=89g@mail.gmail.com>
 <314a3582-0103-40e1-a7a3-274897f5950d@gmail.com>
 <CA+iibzDc=45P+U-xd6gxQBCqrEtb4ENFewFfzof91a9cU8OErA@mail.gmail.com>
 <4bcf6591-168a-446c-b6ff-b8ba5f7efedb@gmail.com>
 <CA+iibzDAZ0QSH9yXBgNd_CrOA3Z69z3yhbZMaiPjMUE8ZG8u0w@mail.gmail.com>
 <CAPv5Ue71TT7dDpe6TZQSimCztT3iQew30C7i0syZb=5JhiYCOw@mail.gmail.com>
 <CA+iibzB3j__Xe2VtpEr-5BH+kcJRM06UxcxWVmVZxHVyNMWsyg@mail.gmail.com>
 <CAPv5Ue6n1BF5E=c3u_cwcHZd+L++v4X8waqKmpW9sgQNvHVSxQ@mail.gmail.com>
 <CA+iibzCRmWL9H2smcsW31744i6AVc2Y68Juw9dEA2BV8AsKK+Q@mail.gmail.com>
 <6e9698e9-8dfd-4819-99d0-0a75c20c3778@gmail.com>
Content-Language: en-US
In-Reply-To: <6e9698e9-8dfd-4819-99d0-0a75c20c3778@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 8/28/24 4:56 AM, James Prestwood wrote:
> Hi Daniel,
>
> On 8/28/24 3:41 AM, daniel antoine wrote:
>> Hi James
>>
>> The last commits on netdev have made the patches for the CQM problem
>> incompatible. I got the errors when I tried to compile with the
>> patches
>>
> Yep looks like those patches never got merged, and I forgot about 
> them. I'll send a rebased v4 update and we can see about getting those 
> upstreamed.
A new patch set has been sent to the list (actually v3, not v4). I 
verified it works with my mediatek card with the same failure but if you 
could as well that would be appreciated.
>
> Thanks,
>
> James
>
