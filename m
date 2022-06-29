Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729006AA2
	for <iwd@lists.linux.dev>; Wed, 29 Jun 2022 21:00:53 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id e40so23918358eda.2
        for <iwd@lists.linux.dev>; Wed, 29 Jun 2022 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=NntMWLZBHuXP8ISylSBf0oXzqcQJmqyH094O8mGw+BjN0AAegldoKokODt4ZY9mZUA
         9yyGvNGYVBh2WcFD1HbCwBRhxlOOHIjgZxXSF8W/nfQ44AFQuBy8+thLHYjejVlrD4zR
         oTDD+H6u/12QJJXsYstKNfkhfgQuD/ONA+O5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=erwGvy0G7fXQp0iKI+v6f/L+bYz53HlYB+s79ebA4MHhr/ay3eVqHkXtTUUhx1kNYY
         G6fqOjFUuQ55UCGADdJP+EKYULVcU1N5MJcVj5/UcNyQvPZyBTOQ4mVfubGaE0Yd2xk/
         D9fcNTUwJIhvdKnfX2Bhd4JSjagwc1hg0MjPdIiM+TbnIgaI5xIT5zoYDU6vMUgVL1/J
         Qn3+xJgOaG7n5TAsyuq4GeQl3DtolmVLlTz93q9igLRfFeckBlklbwt1ZIOtTa8S2bZV
         R09/hIjH4Wh5O4ecKRZhA9bZo/O6hnU3Y/tHPeAV555ylvh4yAtf4qRz8D2XCqWjg+uo
         Eqgg==
X-Gm-Message-State: AJIora/yNnmysOkof5m2HF8SPlnVMH6YnRk51TeB1W4JP9AOR790VVQa
	lkwwEzQmFj7XosUJnLW1fbI4V6dUI+olp+J6
X-Google-Smtp-Source: AGRyM1u0gUKkz60B8vkobdKBvAzR0izLgfxHQmWt15RB0XfSiMge9j5171mxmv2eDeNvV97BfHEP1w==
X-Received: by 2002:a05:6402:750:b0:435:68bb:8552 with SMTP id p16-20020a056402075000b0043568bb8552mr6777737edy.155.1656536451624;
        Wed, 29 Jun 2022 14:00:51 -0700 (PDT)
Received: from localhost (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id ia10-20020a170907a06a00b0070b7875aa6asm8026950ejc.166.2022.06.29.14.00.49
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:00:50 -0700 (PDT)
Date: Wed, 29 Jun 2022 23:00:49 +0200
From: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
To: iwd@lists.linux.dev
Subject: unsubscribe
Message-ID: <20220629210049.oqeafvvbpow6kqye@pqrs.dk>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

