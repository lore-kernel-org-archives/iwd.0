Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A44A37
	for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 20:55:35 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id o184so12887722oif.13
        for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 13:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=nia5ArqoczcWAxBOhPhZ0LDddNFRMznWj85Tf0muGus=;
        b=UcecXKVoKOo8pJWJNt3doVqtl+KCsZtUVAs/vDHpq7MzEgZHmrF6W/UV37+veS6yOO
         7Vkut9fOZP/P8q1NNUCnXj7ycEOOIKOcjDc5m67rpEqEJ1hLu6E/ViC0bvkE9Aown0Sj
         Ru0IXtvUj3F7r4Uot7BtdH52rmFdyFXBFKcbiDR/U96SuNhUsPlFZz/6K2wXMMFRNVE3
         hWcUmuPQwh1K/3zJHIIbiwG5O2WgYQZx3Bz5TCVLXtcOzfdhqU7ok6hLcW1c6bErXVEi
         7ZdHIxmCVJnhOnjpPGB+GGyihdu+9YbVOrVO+WqCJbZsMqmdydWVY7XFbqxnXNOF56Pw
         UDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nia5ArqoczcWAxBOhPhZ0LDddNFRMznWj85Tf0muGus=;
        b=cGAAxGmEis3LU7LjyKJzgaIMYAFFl3qD4zP6WZ4l4AWgpfD7e9VTpZ7vAmdDDugV4Z
         2TwjE85FJH7IVd2AwiRMd2ivNKBkV313xwGgZnT2Z1KSrpkN0NcPSBxgymXKIJn21Ata
         /U0IgtdA/mWgWhd4ol2ammaqyY5reYwsfaHogF/xt1ytjLZx+OYeE988LQIniWYjuVrJ
         OwOSJm6fQrc0Xa0TfHZHvykIIegUVkORk3ZBvDn4oO9/vmA3DJBv8DHS14I9ajcmTqhf
         LyL1V9NAqVFH0U6fQ8bN9MX+GNYz5Zgbp8DDNocJCYb9teagJkO9Ogo/VxAfmSzoFhpp
         fyMA==
X-Gm-Message-State: ACgBeo02ekZn+9vurtslosNzIFUI3SaMgp/fH6kvNkodbAi3oDQemcLb
	9DioAWB5Fd1OtoqTXSZ1xxA=
X-Google-Smtp-Source: AA6agR7+T+3sSqQF8svm1pj5L0H2WokZ/TEmuqYDSyXqM1kOCTbP1Br5wS7TQKV5FEXgsrG7zniZLw==
X-Received: by 2002:a05:6808:150b:b0:343:482a:4215 with SMTP id u11-20020a056808150b00b00343482a4215mr2348891oiw.53.1660251334560;
        Thu, 11 Aug 2022 13:55:34 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id l6-20020a056820030600b00441b98453d8sm39261ooe.8.2022.08.11.13.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 13:55:34 -0700 (PDT)
Message-ID: <5a4c3510-e1ce-e30c-c351-bad206285248@gmail.com>
Date: Thu, 11 Aug 2022 15:48:57 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/6] doc: add documentation for StationDebug
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220811184735.465951-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220811184735.465951-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/11/22 13:47, James Prestwood wrote:
> ---
>   doc/station-debug-api.txt | 68 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
>   create mode 100644 doc/station-debug-api.txt
> 
> v3:
>   * Removed the special /hidden object
> 

All applied, thanks.

Regards,
-Denis

