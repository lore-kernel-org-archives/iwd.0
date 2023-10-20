Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECCF1DA32
	for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZfXVYWj"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-581f78a0206so491140eaf.2
        for <iwd@lists.linux.dev>; Fri, 20 Oct 2023 08:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697815173; x=1698419973; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSgs88hzyh16KRT+B2S23jRMlcORjHwCEZE+k/GkL1I=;
        b=mZfXVYWjdhBkEua+qXNxWupu3+tGj37wm4koRsy2hseMor9RPutj4p3n2vN932kQDg
         BymSGv1LZLFI96pzl/mcsQcg7ryZWjvHf4awXDIbCGTrCkI3h+jgOsMjp3pX0+/xBRW/
         SoEEXCtVzw+TCuJJnxJGWxly2hhS2qZPt9ZCuACbKuILn8XO7BNqszUYAHGZFj9gt4Nq
         eJPx51oqRMXqptphvF5X7lBvVqnZXcUbRaEa8lOCthLZhNmRol3q4Cln50Y8oXf9mlIN
         Z/jgn3px2LYtL4J1rmc94k8dG3xJ6oEZfFbvCtppQZShJ/GxNLMBqorrkYaf5gOWBQqc
         PStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697815173; x=1698419973;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSgs88hzyh16KRT+B2S23jRMlcORjHwCEZE+k/GkL1I=;
        b=R2ohdaYHd/8I/Hjd5HVquvrwcxn9IGmobUKyhNsMyWxoo5s4Ehk1z64zpHWUipRCDh
         OraOvL6VUNbOYody4aD4DJNGW6uH/ogahJwievX5MwcczMGCvnfh747Q8oE5kxDu2D/N
         xTJLegHOVUjY604ED9Xjo8PAYwuLae3weEyPMs7XRbE83Z1mAT34fqerk6HsL340RY4+
         GRr4XixrXP3QtIdcbg4T2GROD5CK5b6+5ABnOG3dENIgd1+7U6URl+FAZHH3LYy6cSxS
         tmKdGZs9+MxBliHZOnOYQyXJKIBNyOSpSJ4eACag3Sx+UDQi6JfT/7vNExxg51AXqnlC
         ihHQ==
X-Gm-Message-State: AOJu0YxFIiQ7LB+6Q62ZtunNqpOz0h/Gy+b0F6HsRZUTsnoT2hPzra6c
	wlo5yX4m0/wHV6t+q3V7LRE=
X-Google-Smtp-Source: AGHT+IFlQR0EIArDmsUROxwz8Oj0tYIY5fEojUV2jb/BIsJO7oUbnynquyNcCnIO7SkkIlSnAZay0g==
X-Received: by 2002:a4a:b789:0:b0:581:df34:15c with SMTP id a9-20020a4ab789000000b00581df34015cmr2284763oop.5.1697815173505;
        Fri, 20 Oct 2023 08:19:33 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id n11-20020a4ae1cb000000b0057b8baf00bbsm381444oot.22.2023.10.20.08.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 08:19:33 -0700 (PDT)
Message-ID: <095e9190-adf5-47cb-8d8d-78c2a46b8f63@gmail.com>
Date: Fri, 20 Oct 2023 10:19:31 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: install iwd-decrypt-profile
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231003192456.4038590-1-prestwoj@gmail.com>
 <a8885dd9-eeff-4318-b7c9-5f54a3273913@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <a8885dd9-eeff-4318-b7c9-5f54a3273913@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/20/23 07:52, James Prestwood wrote:
> Resending in case this got missed.
> 

Didn't Marcel reply to this:
https://lore.kernel.org/iwd/F6D1FD48-E7AC-404B-936A-E4D5E3519FA2@holtmann.org/

Regards,
-Denis
