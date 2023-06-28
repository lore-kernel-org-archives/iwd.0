Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75696C8E3
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 15:29:27 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6b5d1498670so4609450a34.1
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 08:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687966166; x=1690558166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7eXYxSvZ+6uyYraN3wlR0cna/wRc3KINau29BDrwBo=;
        b=gqFiv0FUJWDE1vNRR9Xnt/rMYH44YFF2LH9jqcMcfWVxQ0oxSqmgRJPr+kmygodsP4
         jALPQPyh+hYFwxwSVxpomvsC15T/r1e6pydkfWf9EJZqcyfcSsuwdviDarlG5MTeutKo
         58IgKdtblBfSeDD8NVgyZGd5kZW7jD5Q7WYhzSFqQbOybjxErjuTNv88t/WFyZLnV/F3
         V2pQCjGIv2z4s3vHV0idn2GgZal+9TFDCVlojefvYCXMWV7HpXxricGQkAdjmQ0GomUi
         NCRY70X6evo0D1pn/FONg7W7Dm5xfXnjHnVThWhq57q7yHOD/hbY9YDWCLEKngyUmSh7
         burw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687966166; x=1690558166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7eXYxSvZ+6uyYraN3wlR0cna/wRc3KINau29BDrwBo=;
        b=Olvhs+5Nc1c86FhhRucAdFeqXKnYn5v3ZrLyO8cqJj/Y6UcIx+gYQmE8NVqRx6YW7e
         Aym7RaZxlN7Dn+mUFCRxOwBe1Qxfj1sjoLu+EcaTwJVf8DzOBbHw29ua4F9bACZIuwHs
         Nq+Igxy1CWTU7LcI9/Mt1cPN5YtQ5s+o4MDM5+i/tvtbTz+3m1XF45uDuv1gmcMAVdDy
         CecNQ8GCaesGb4utCnAQ/nNQ0kft45PWj8fZNDcodZDkV4pxypwjH01Pp9A4S3wD6XhR
         R6wLL6KxkEJDm2q9o5wl+SnERnKJM3J70yA6yPS5O6uqpIYhbI/AwpWtTsn9XtZ6vDpP
         Rhuw==
X-Gm-Message-State: AC+VfDxmkMRQxTbEPqdHrn+eKWJ6ISoWvQt3trBHJz7cQUGzi+7UImgH
	TJhybxl/VuQwf0QVlX0HFBg=
X-Google-Smtp-Source: ACHHUZ4cUv+5PFUol89EJcsIzeRn1RcV/5yedHW7bjnOdzo6sx7nV31DjdR8tEg5lSzQEJ7F67CfYg==
X-Received: by 2002:a9d:77d5:0:b0:6b7:6a50:b95f with SMTP id w21-20020a9d77d5000000b006b76a50b95fmr6265569otl.37.1687966166411;
        Wed, 28 Jun 2023 08:29:26 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id h17-20020a9d6411000000b006b720475c38sm4823733otl.45.2023.06.28.08.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 08:29:25 -0700 (PDT)
Message-ID: <f36812fc-9165-fde1-03ea-2ba34d1542c5@gmail.com>
Date: Wed, 28 Jun 2023 10:27:13 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: iwd forgets network
Content-Language: en-US
To: Martin Petzold <martin.petzold@tavla.de>,
 James Prestwood <prestwoj@gmail.com>
Cc: James Tavares <jtavares@kvh.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <7794c62a-56d2-d34a-06e9-0b17edb235f7@tavla.de>
 <61D86659-745B-4228-AC0D-216E5CA292D2@kvh.com>
 <85b9e54c-dea7-672e-ecad-9382c8f6a7e7@tavla.de>
 <9d7f0362-67af-bbc4-2cc0-d4f8da123cd3@gmail.com>
 <e6f29266-7a7d-1fcf-2ce9-e96efe75a13d@tavla.de>
 <2f0cc99c-c547-1150-d667-8fd667be86ae@gmail.com>
 <5448805b-253d-eeb6-33f2-881eb8be2157@tavla.de>
 <303737c5-0191-378f-d164-5434ed0e3c40@gmail.com>
 <d2d75c80-a10a-67fd-07d3-3706bd008881@tavla.de>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <d2d75c80-a10a-67fd-07d3-3706bd008881@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

> 
> Nothing special. And also, this is not about power-loss. I cannot remember this 
> happened after a power-loss. I can only remember that we did a reset of the 
> router which the device was connected.

iwd only calls unlink() in three places:
  1. storage_network_remove() which is only called due to KnownNetwork.Forget()
  2. hotspot_network_remove(), which is also called due to KnownNetwork.Forget()
  3. failure path inside write_file(), but that one only unlinks the temporary.

Since you say you're not calling the Forget() path, it isn't clear what could be 
causing this.  Having some additional instrumentation either by modifying iwd 
with additional logging or some sort of external tracing would help.

Regards,
-Denis
