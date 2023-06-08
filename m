Received: from mta06-relay.cloud.vadesecure.com (mta06-relay.cloud.vadesecure.com [163.172.55.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7F910975
	for <iwd@lists.linux.dev>; Thu,  8 Jun 2023 14:38:35 +0000 (UTC)
Received: from mail01.bodet.com (unknown [84.239.65.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mta06-relay.cloud.vadesecure.com (vceu3mtao02p) with ESMTPS id 4QcRV61ggBz7WRp;
	Thu,  8 Jun 2023 16:31:26 +0200 (CEST)
Received: from BODMAIL01.TREM.BOD (172.18.41.21) by BODMAIL02.TREM.BOD
 (172.18.41.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 8 Jun
 2023 16:31:25 +0200
Received: from BODMAIL01.TREM.BOD ([::1]) by BODMAIL01.TREM.BOD ([::1]) with
 mapi id 15.01.2507.023; Thu, 8 Jun 2023 16:31:25 +0200
From: "clement.legoffic@kelio.com" <clement.legoffic@kelio.com>
To: James Prestwood <prestwoj@gmail.com>, "iwd@lists.linux.dev"
	<iwd@lists.linux.dev>
Subject: RE: IWD Not Starting anymore
Thread-Topic: IWD Not Starting anymore
Thread-Index: AdmaEULNoZi1MHxtRuy3GNjL6IbSmP//5BAA///bT2A=
Date: Thu, 8 Jun 2023 14:31:25 +0000
Message-ID: <37aba90354d048e9ac3a61bc16e461be@kelio.com>
References: <032bbeb106b34730939e1e605425af5b@kelio.com>
 <fdcd4f17-2b9a-3eee-934c-ce820b805cf7@gmail.com>
In-Reply-To: <fdcd4f17-2b9a-3eee-934c-ce820b805cf7@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [172.18.114.30]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-VRC-SPAM-STATUS: 0,-100,gggruggvucftvghtrhhoucdtuddrgedvhedrgedtiedgjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftvedpqfgfvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggsehtsghjtddttdejnecuhfhrohhmpedftghlvghmvghnthdrlhgvghhofhhfihgtsehkvghlihhordgtohhmfdcuoegtlhgvmhgvnhhtrdhlvghgohhffhhitgeskhgvlhhiohdrtghomheqnecuggftrfgrthhtvghrnhepvdelffelleeukeevtdejveeufedvfeefffffheeiveeutdffieetvdevtddtleetnecukfhppeekgedrvdefledrieehrdeljedpudejvddrudekrdduudegrdeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhmrgigmhhsghhsihiivgepuddtgeekheejiedpihhnvghtpeekgedrvdefledrieehrdeljedphhgvlhhopehmrghilhdtuddrsghouggvthdrtghomhdpmhgrihhlfhhrohhmpegtlhgvmhgvnhhtrdhlvghgohhffhhitgeskhgvlhhiohdrtghomhdpnhgspghrtghpthhtohepvddprhgtphhtthhopehprhgvshhtfihojhesghhmrghilhdrtghomhdprhgtphhtthhopehifigusehlihhsthhsrdhlihhnuhigrdguvghv
X-VRC-SPAM-STATE: legit
X-VRC-POLICY-STATUS: t=1,a=1,l=0

VGhhbmsgeW91IGZvciB5b3VyIHJlc3BvbnNlICENCkkgcmVtb3ZlIHRoZSBob3RzcG90IGRpcmVj
dG9yeSBhbmQgSSB3YXMgYWJsZSB0byByZWxhdW5jaCBpd2QgY29ycmVjdGx5ICENCiANCj4gSGkg
Q2xlbWVudCwNCj4gDQo+IE9uIDYvOC8yMyA2OjU4IEFNLCBjbGVtZW50LmxlZ29mZmljQGtlbGlv
LmNvbSB3cm90ZToNCj4gPiBIZWxsbywNCj4gPg0KPiA+IEkgYW0gdXNpbmcgaXdkIG9uIGFuIGVt
YmVkZGVkIHRhcmdldCBmb3Igc2ltcGxlIHRhc2sgZm9yIGEgd2hpbGU6DQo+IGNvbm5lY3Rpb24s
IGRpc2Nvbm5lY3Rpb24sIHNjYW4uDQo+ID4gVmVyc2lvbiAxLjI1DQo+ID4gSSBkb24ndCB1c2Ug
c3lzdGVtZC4NCj4gPiBGb3IgYSB3aGlsZSwgaXQgaGFzIGJlZW4gd29ya2luZyB3ZWxsIHdpdGgg
UFNLIGFuZCBFQVAtVExTLg0KPiA+IEJ1dCBub3csIEkgY2FuJ3QgZXZlbiBzdGFydCBpd2QuIEhl
cmUgaXMgdGhlIGRlYnVnIG91dHB1dCA6DQo+ID4NCj4gPiByb290QHRhcmdldCB+PiAvdXNyL2xp
YmV4ZWMvaXdkIC1kDQo+ID4gV2lyZWxlc3MgZGFlbW9uIHZlcnNpb24gMS4yNQ0KPiA+IHNyYy9t
YWluLmM6bWFpbigpIFVzaW5nIGNvbmZpZ3VyYXRpb24gZGlyZWN0b3J5IC9ldGMvaXdkDQo+ID4g
c3JjL3N0b3JhZ2UuYzpzdG9yYWdlX2NyZWF0ZV9kaXJzKCkgVXNpbmcgc3RhdGUgZGlyZWN0b3J5
IC92YXIvbGliL2l3ZA0KPiA+IHNyYy9tYWluLmM6bmw4MDIxMV9hcHBlYXJlZCgpIEZvdW5kIG5s
ODAyMTEgaW50ZXJmYWNlDQo+ID4gc3JjL21vZHVsZS5jOml3ZF9tb2R1bGVzX2luaXQoKQ0KPiA+
IHN0YXRpb246IE5ldHdvcmsgY29uZmlndXJhdGlvbiBpcyBkaXNhYmxlZC4NCj4gPiBzcmMvd3Nj
LmM6d3NjX2luaXQoKQ0KPiA+IE1vZHVsZSBob3RzcG90IGZhaWxlZCB0byBzdGFydDogLTINCj4g
PiBzcmMvbW9kdWxlLmM6aXdkX21vZHVsZXNfZXhpdCgpDQo+ID4gc3JjL3dzYy5jOndzY19leGl0
KCkNCj4gPiBELUJ1cyBkaXNjb25uZWN0ZWQsIHF1aXR0aW5nLi4uDQo+ID4NCj4gPiBJIGRvbid0
IHVuZGVyc3RhbmQgaXRzIG5ldyBiZWhhdmlvdXIuDQo+ID4gVGhlIC9ldGMvaXdkL21haW4uY29u
ZiBpcyBlbXB0eS4NCj4gPiBBbSBJIGRvaW5nIGl0IHdyb25nID8NCj4gPiBEbyB5b3UgaGF2ZSBh
bnkgbGVhZCA/DQo+IA0KPiBTbyB0aGUgIk1vZHVsZSBob3RzcG90IGZhaWxlZCB0byBzdGFydCIg
aXMgYmVjYXVzZSBlaXRoZXIgdGhlcmUgaXMgbm8NCj4gL3Zhci9saWIvaXdkL2hvdHNwb3QgZGly
ZWN0b3J5IG9yIHRoZSBwZXJtaXNzaW9ucyB3ZXJlIHN1Y2ggdGhhdCBJV0QNCj4gY291bGQgbm90
IGNhbGwgb3BlbmRpcigpLg0KPiANCj4gU28gY2hlY2sgdGhhdCBkaXJlY3RvcnkgYW5kIHNlZS4g
SSBzdXNwZWN0IHBlcm1pc3Npb25zIGJlY2F1c2UgSVdEIHdpbGwNCj4gY3JlYXRlIHRoYXQgZGly
ZWN0b3J5IGlmIGl0IGRvZXNuJ3QgZXhpc3QuDQo+IA0KPiA+DQo+ID4gVGhhbmtzIGluIGFkdmFu
Y2UsDQo+ID4NCj4gPiBDbMOpbWVudA0KPiA+DQoNCkNsw6ltZW50DQo=
