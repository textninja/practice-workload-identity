import { Storage } from '@google-cloud/storage';
import { SecretManagerServiceClient } from '@google-cloud/secret-manager';
import { BigQuery } from '@google-cloud/bigquery';
import chalk from 'chalk';

// 1. access a cloud storage bucket

const storage = new Storage;
const bucket = await storage.bucket(process.env.NJAPWI_GCP_BUCKET);
const [files] = await bucket.getFiles();
console.log(`There are ${chalk.bold(files.length)} files in your GS bucket.`);

// 2. access a cloud secret

const secretManager = new SecretManagerServiceClient;
const [version] = await secretManager.accessSecretVersion({
  name: process.env.NJAPWI_SECRET_VERSION_NAME
});
console.log(chalk.bold('Secret contents: ') + version.payload.data);

// 3. access a bigquery table

const bigquery = new BigQuery;
const [job] = await bigquery.createQueryJob({
  query: `
    select name
    from \`bigquery-public-data.usa_names.usa_1910_2013\`
    where state = 'TX'
    limit 100
  `,
  location: 'US'
});

console.log(`Job ${job.id} started.`);

const [rows] = await job.getQueryResults();

console.log('Rows: ');
rows.forEach(row => {
  console.log(row);
});


// 4. access cloud sql

// TODO
