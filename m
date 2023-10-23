Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37E118E1B
	for <iwd@lists.linux.dev>; Mon, 23 Oct 2023 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxwZLKB7"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-77896da2118so214472285a.1
        for <iwd@lists.linux.dev>; Mon, 23 Oct 2023 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698064533; x=1698669333; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DftFWEaQCF4zgvn+4d828PCjIUz+FqOgkfMfFnvRMdE=;
        b=YxwZLKB73BDd0qCS9u1Y4UGId7JEKB0zn58tvxk6o8KiE4NJlcGMU6IJernhoQqVen
         yb9gWjMbqCBArLw/vkE8eJjR61VXbIY+DmAAb/GqaD++4WhTgDNRjDitiGplZ33gvfFe
         wfBjPM47Opa1o3kslseLHoTWzmYEYnjxVCJJqakO5CSNd9MIm7j6uDHslO3I6sVWCNdu
         yGEtGrsqOLgxlSTX6IcYQh++KuT9g17CvXlZFrxzT6yXwh3mNwUsbLIwCBhwsCytuhao
         2hfWN0G9IINjYKVNdi0MVp2htuOMANcQk73+2spVd+QwzAeLD8qUztgpKB2muH3Eus1i
         Au3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698064533; x=1698669333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DftFWEaQCF4zgvn+4d828PCjIUz+FqOgkfMfFnvRMdE=;
        b=dD56Bs4RmlpPDC1bOZ2cw6iajliJvAlhvEoDmYsmFaGufcFgdF6RXwUxF6xQDosBY3
         3nm8KdusltlAOrNC52EhEm5NfyR0FRMmPFAESFtjwmeVyK0+DgWN5dCIylOHeTKlt9OT
         MdHgbYD8vuWsqCChzIk3Rcp0v4ylhK3+ezyqQT6gQcB6mGGhEuWAebseLyMyALmi5Pdi
         7ZtjVr8MtNZ3TZIc6oKU4Oqys3p23f/6d6MPr0wEUYj7fJQZL05FGf2rQLzzaXcumZ+F
         E3LyXSoWx0zEmyguEl4Jlcy5t8WFh1CqMQ1qIVxssZaqhK91lXRM0wDoAFwNvdA/ERTK
         +mSg==
X-Gm-Message-State: AOJu0Ywms1uuiscWE8zdOffxH/wJfIwSgU3VCZ6p9vC5plP9Sa0LIQdg
	rU5cyMVypl/zlGTDbq9anoIiajK4Fig=
X-Google-Smtp-Source: AGHT+IHiGd9ZiY9d/vyNtRAiPCmmBJ59ybbDfvMV6FdJv6lXTg016ryVotxMZgJe7unU+ZipZrSnYQ==
X-Received: by 2002:a05:6214:2524:b0:66d:4173:5ad1 with SMTP id gg4-20020a056214252400b0066d41735ad1mr11038224qvb.39.1698064533477;
        Mon, 23 Oct 2023 05:35:33 -0700 (PDT)
Received: from [10.102.4.159] (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id pe1-20020a056214494100b0066d1d860cd1sm2846574qvb.19.2023.10.23.05.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 05:35:33 -0700 (PDT)
Message-ID: <fed677e4-28f5-4ff7-8f3c-a436484f1bc5@gmail.com>
Date: Mon, 23 Oct 2023 05:35:30 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/21] dpp-util: add __DPP_STATUS_MAX
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
References: <20231012200150.338401-1-prestwoj@gmail.com>
 <20231012200150.338401-14-prestwoj@gmail.com>
 <0b431079-40f8-4aa1-a82d-01c9a5bfbe5f@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <0b431079-40f8-4aa1-a82d-01c9a5bfbe5f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Denis,

On 10/19/23 8:16 AM, Denis Kenzior wrote:
> Hi James,
> 
> On 10/12/23 15:01, James Prestwood wrote:
>> Nice for setting as an invalid status since STATUS_OK is
>> already zero.
> 
> But this enum comes directly from the spec?

Not __DPP_STATUS_MAX obviously, but yes the other status' are all part 
of the spec. Having an "invalid" enum value is just convenient since I 
can check it by value instead of having to store an additional pointer 
to check if the attribute was included:

...
case DPP_ATTR_STATUS:
     status_ptr = data;
     break;
...

if (!status_ptr)
     goto fail;

if (*status_ptr != DPP_STATUS_OK)
     goto fail;

This is how we do it elsewhere though so I can do it this way. To be 
fair, its just an extra if :)

> 
>> ---
>>   src/dpp-util.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/src/dpp-util.h b/src/dpp-util.h
>> index 6b00796e..61f1c859 100644
>> --- a/src/dpp-util.h
>> +++ b/src/dpp-util.h
>> @@ -71,6 +71,7 @@ enum dpp_status {
>>       DPP_STATUS_CSR_NEEDED,
>>       DPP_STATUS_CSR_BAD,
>>       DPP_STATUS_NEW_KEY_NEEDED,
>> +    __DPP_STATUS_MAX,
> 
> In general iwd/ell do not use such constructs since it makes handling of 
> enums in switch/case statements a bit more painful.

Thats fine, I can do it like the above pseudocode.

Thanks,
James

> 
>>   };
>>   enum dpp_attribute_type {
> 
> Regards,
> -Denis
